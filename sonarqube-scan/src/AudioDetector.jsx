import React, { useEffect, useRef } from 'react';

const AudioDetector = ({ onBlowDetected, onMicStatus }) => {
  const audioContextRef = useRef(null);
  const analyserRef = useRef(null);
  const dataArrayRef = useRef(null);

  useEffect(() => {
    let rafId;

    const startAudio = async () => {
      try {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        onMicStatus?.(true);

        audioContextRef.current = new (window.AudioContext || window.webkitAudioContext)();
        const source = audioContextRef.current.createMediaStreamSource(stream);
        analyserRef.current = audioContextRef.current.createAnalyser();
        analyserRef.current.fftSize = 2048;
        dataArrayRef.current = new Uint8Array(analyserRef.current.frequencyBinCount);
        source.connect(analyserRef.current);

        const detect = () => {
          if (!analyserRef.current) return;
          analyserRef.current.getByteTimeDomainData(dataArrayRef.current); // or getByteFrequencyData
          let sum = 0;
          for (let val of dataArrayRef.current) {
            sum += Math.abs(val - 128); // deviation from silence (center is 128 in time domain)
          }
          const average = sum / dataArrayRef.current.length;

          // Tune this threshold: 8-20 often works well for blowing (louder & noisier than speech)
          if (average > 12) {
            onBlowDetected();
          }
          rafId = requestAnimationFrame(detect);
        };
        detect();
      } catch (err) {
        console.error('Mic error:', err);
        onMicStatus?.(false);
      }
    };

    startAudio();

    return () => {
      cancelAnimationFrame(rafId);
      if (audioContextRef.current) audioContextRef.current.close();
    };
  }, [onBlowDetected, onMicStatus]);

  return null;
};

export default AudioDetector;