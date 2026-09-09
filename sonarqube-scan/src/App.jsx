import React, { useState, useEffect } from 'react';
import Confetti from 'react-confetti';
import { Howl } from 'howler';
import CakeScene from './CakeScene';
import Balloons from './Balloons';
import AudioDetector from './AudioDetector';

function App() {
  const [candlesLit, setCandlesLit] = useState(true);
  const [showBalloons, setShowBalloons] = useState(false);
  const [showConfetti, setShowConfetti] = useState(false);
  const [micAllowed, setMicAllowed] = useState(null);
  const [music, setMusic] = useState(null);

  // Personalize here
  const friendName = "Srinithi";
  const friendPhoto = "./assets/Srinithi.jpeg";

  useEffect(() => {
    const bgMusic = new Howl({
      src: ['./assets/happy-birthday.mp3'],
      loop: true,
      volume: 0.35,
      html5: true,
    });
    setMusic(bgMusic);

    return () => bgMusic.unload();
  }, []);

  const handleBlowOut = () => {
    if (!candlesLit) return;
    setCandlesLit(false);
    setShowBalloons(true);
    setShowConfetti(true);

    if (music && !music.playing()) music.play();

    setTimeout(() => setShowConfetti(false), 7000);
  };

  const handleMicStatus = (allowed) => setMicAllowed(allowed);

  return (
    <div className="min-h-screen flex flex-col items-center justify-center p-4 sm:p-6 md:p-8 relative overflow-hidden">
      {/* Background decorative elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-10 left-10 w-24 h-24 bg-pink-300/20 rounded-full blur-3xl animate-pulse" />
        <div className="absolute bottom-20 right-20 w-32 h-32 bg-purple-300/20 rounded-full blur-3xl animate-pulse delay-1000" />
      </div>

      {showConfetti && <Confetti numberOfPieces={300} gravity={0.12} tweenDuration={6000} />}

      <main className="w-full max-w-4xl z-10">
        {/* Header / Title */}
        <div className="text-center mb-10">
          <h1 className="pb-2 text-4xl sm:text-6xl md:text-7xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-pink-600 via-purple-600 to-pink-500 drop-shadow-lg animate-pulse">
            🎂 Happy Birthday 🎂
          </h1>
          <p className="text-4xl sm:text-5xl font-cursive text-pink-700 mt-2 drop-shadow-md">
            💖{friendName}💖
          </p>
        </div>

        {/* Photo + Message Card */}
        <div className="flex flex-col md:flex-row items-center justify-center gap-8 mb-12">
          <div className="bg-white/70 backdrop-blur-md p-6 sm:p-8 rounded-3xl shadow-xl border border-white/30 max-w-md text-center">
            <p className="text-xl sm:text-2xl text-gray-800 font-medium">
              Blow out the candles{friendName ? ` ${friendName}` : ''} and celebrate! 🎈🥳
            </p>
          </div>
        </div>

        {/* Cake Section - centered */}
        <div className="flex justify-center mb-10">
          <div className="bg-white/60 backdrop-blur-lg p-8 sm:p-12 rounded-3xl shadow-2xl border border-white/40 transform hover:scale-[1.02] transition-transform duration-300">
            <CakeScene candlesLit={candlesLit} onBlowOut={handleBlowOut} />
          </div>
        </div>

        {/* Mic fallback */}
        {micAllowed === false && (
          <div className="bg-white/80 backdrop-blur-md p-6 rounded-2xl shadow-lg max-w-md mx-auto text-center mb-8 border border-pink-200">
            <p className="text-lg text-gray-700 mb-4">
              Microphone access not available or denied 😕
            </p>
            <button
              onClick={handleBlowOut}
              className="px-8 py-4 bg-gradient-to-r from-pink-500 to-purple-500 text-white font-bold text-lg rounded-full shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-300 active:scale-95"
            >
              Pretend Blow + Celebrate! 🎉
            </button>
          </div>
        )}

        {/* Balloons appear here */}
        {showBalloons && <Balloons />}

        {/* Audio detector */}
        {(micAllowed === null || micAllowed === true) && (
          <AudioDetector onBlowDetected={handleBlowOut} onMicStatus={handleMicStatus} />
        )}
      </main>
    </div>
  );
}

export default App;