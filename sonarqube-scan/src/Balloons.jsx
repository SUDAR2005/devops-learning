import React, { useMemo } from 'react';
import { motion } from 'framer-motion';

// Helper for random numbers
const random = (min, max) => Math.random() * (max - min) + min;

const Balloons = () => {
  const balloons = useMemo(() => {
    return Array.from({ length: 12 }, (_, i) => ({
      id: i,
      color: [
        '#ff9aa2', '#ffb7b2', '#ffd7a0', '#e2f0cb', '#b5ead7',
        '#c7ceea', '#ff9cc7', '#a8e6cf', '#ffd3b6', '#ffaaa5',
        '#ffd166', '#ef476f'
      ][i % 12],
      left: random(5, 95),
      delay: random(0, 3),
      duration: random(7, 12),
      drift: random(-120, 120),
      rotate: random(-30, 30),
      swayAmount: random(20, 60),
    }));
  }, []);

  return (
    <div className="fixed inset-0 pointer-events-none overflow-hidden z-20">
      {balloons.map((balloon) => (
        <motion.div
          key={balloon.id}
          className="absolute bottom-[-150px] w-20 h-24 sm:w-24 sm:h-28 origin-bottom"
          style={{
            left: `${balloon.left}%`,
            transformOrigin: 'bottom center',
          }}
          initial={{ y: 0, rotate: 0, scale: 0.7 }}
          animate={{
            y: [-150, -window.innerHeight - 400],
            x: [0, balloon.drift],
            rotate: [0, balloon.rotate, -balloon.rotate / 1.5, 0],
            scale: [0.7, 1.1, 0.95, 1.05],
          }}
          transition={{
            duration: balloon.duration,
            delay: balloon.delay,
            ease: 'easeOut',
            times: [0, 0.35, 0.7, 1],
          }}
        >
          {/* Heart-shaped balloon */}
          <div
            className="relative w-full h-full"
            style={{
              background: `linear-gradient(135deg, ${balloon.color}, ${balloon.color}cc)`,
              borderRadius: '50% 50% 50% 50% / 60% 60% 40% 40%',
              boxShadow: '0 15px 35px rgba(0,0,0,0.25)',
              border: '2px solid rgba(255,255,255,0.5)',
              overflow: 'hidden',
            }}
          >
            {/* Shine highlight */}
            <div className="absolute top-2 left-4 w-6 h-6 bg-white/50 rounded-full blur-sm" />

            {/* Happy Birthday text - on EVERY balloon */}
            <div className="absolute inset-0 flex items-center justify-center px-2 text-center">
              <span
                className="text-white font-bold drop-shadow-lg tracking-wide"
                style={{
                  fontSize: 'clamp(0.7rem, 2.5vw, 1.1rem)',
                  textShadow: '0 2px 6px rgba(0,0,0,0.6)',
                  lineHeight: '1.1',
                }}
              >
                HAPPY<br />BIRTHDAY!
              </span>
            </div>
          </div>

          {/* Balloon string */}
          <div
            className="absolute left-1/2 bottom-[-90px] w-0.5 h-24 bg-gradient-to-b from-white/60 to-transparent origin-top"
            style={{ transform: 'translateX(-50%)' }}
          />
        </motion.div>
      ))}
    </div>
  );
};

export default Balloons;