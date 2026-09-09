import React from 'react';
import { motion } from 'framer-motion';

const CakeScene = ({ candlesLit, onBlowOut }) => {
  // Define different candle colors (body + flame tint)
  const candles = [
    { body: '#ff6b6b', flame: '#ff9f43' },   // Red → Orange flame
    { body: '#4ecdc4', flame: '#45b7d1' },   // Teal → Cyan flame
    { body: '#9b59b6', flame: '#8e44ad' },   // Purple → Darker purple flame
    { body: '#feca57', flame: '#f1c40f' },   // Yellow → Bright gold flame
  ];

  return (
    <div className="text-center">
      <svg
        width="340"
        height="280"
        viewBox="0 0 340 260"
        className="mx-auto drop-shadow-2xl mt-4"
      >
        {/* Cake base - layered with gradient */}
        <defs>
          <linearGradient id="cakeTop" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stopColor="#fda4af" />
            <stop offset="100%" stopColor="#f472b6" />
          </linearGradient>
        </defs>

        <rect x="30" y="130" width="280" height="110" rx="24" fill="#7c3aed" />
        <rect x="50" y="90" width="240" height="70" rx="18" fill="url(#cakeTop)" />
        <rect x="70" y="50" width="200" height="70" rx="14" fill="#ec4899" />

        {/* Candles - different colors */}
        {candles.map((candle, i) => {
          const x = 80 + i * 60; // spaced evenly
          return (
            <g key={i}>
              {/* Candle body */}
              <rect
                x={x}
                y="20"
                width="16"
                height="38"
                rx="8"
                fill={candle.body}
                stroke="#ffffff33"
                strokeWidth="1.5"
              />

              {/* Wick */}
              <rect
                x={x + 6}
                y="10"
                width="4"
                height="12"
                fill="#2c3e50"
                rx="2"
              />

              {candlesLit && (
                <>
                  {/* Main flame */}
                  <motion.circle
                    cx={x + 8}
                    cy={8}
                    r="10"
                    fill={candle.flame}
                    opacity="0.9"
                    animate={{
                      scale: [1, 1.35, 1],
                      opacity: [0.9, 1, 0.85],
                    }}
                    transition={{
                      duration: 0.9,
                      repeat: Infinity,
                      ease: 'easeInOut',
                      delay: i * 0.12,
                    }}
                  />

                  {/* Inner bright core */}
                  <motion.circle
                    cx={x + 8}
                    cy={6}
                    r="5"
                    fill="white"
                    opacity="0.7"
                    animate={{
                      scale: [1, 1.5, 1],
                    }}
                    transition={{
                      duration: 1.2,
                      repeat: Infinity,
                      ease: 'easeInOut',
                      delay: i * 0.15,
                    }}
                  />

                  {/* Glow halo */}
                  <motion.circle
                    cx={x + 8}
                    cy={8}
                    r="14"
                    fill={candle.flame}
                    opacity="0.25"
                    animate={{
                      scale: [1, 1.4, 1],
                      opacity: [0.25, 0.4, 0.25],
                    }}
                    transition={{
                      duration: 1.8,
                      repeat: Infinity,
                      ease: 'easeInOut',
                      delay: i * 0.18,
                    }}
                  />
                </>
              )}
            </g>
          );
        })}
      </svg>
    </div>
  );
};

export default CakeScene;