import fs from 'fs';
import Player from '../models/card.js';
import Stat from '../models/stats.js';

const players = JSON.parse(fs.readFileSync('./public/players.json', 'utf-8'));


export function addFromFile(req, res) {
    players.forEach(player => {
        const newStat = new Stat(player.stats[0]);
        newStat.save((error, stat) => {
            if (error) {
                console.error(error);
                return;
            }

            const newPlayer = new Player({
                name: player.name,
                image: player.image,
                rating: player.rating,
                stats: [stat._id]
            });
            newPlayer.save();
        });
    });
    res.status(200).json("success");
}


export function generatePack(req, res) {
    Player.find()
        .then(players => {
            const playerIds = players.map(p => p._id);
            const chances = players.map(p => 100000 / (p.rating * p.rating * p.rating));
            const chancesSum = chances.reduce((sum, chance) => sum + chance, 0);
            const normalizedChances = chances.map(chance => chance / chancesSum);
            const pack = [];
            for (let i = 0; i < 13; i++) {
                const randomNumber = Math.random();
                let sum = 0;
                for (let j = 0; j < playerIds.length; j++) {
                    sum += normalizedChances[j];
                    if (sum >= randomNumber) {
                        pack.push(players[j]);
                        playerIds.splice(j, 1);
                        normalizedChances.splice(j, 1);
                        break;
                    }
                }
            }
            res.status(200).json(pack);
        })
        .catch(err => {
            res.status(500).json({ error: err });
        });
}

export function generatePack2(req, res) {
    Player.find()
        .then(players => {
            const playerIds = players.map(p => p._id);
            const chances = players.map(p => 10000000000 / (Math.pow(p.rating - 20, 6) + 10000000000));
            const chancesSum = chances.reduce((sum, chance) => sum + chance, 0);
            const normalizedChances = chances.map(chance => chance / chancesSum);
            const selectedPlayers = new Set();
            const pack = [];
            for (let i = 0; i < 13; i++) {
                const randomNumber = Math.random();
                let sum = 0;
                for (let j = 0; j < playerIds.length; j++) {
                    if (selectedPlayers.has(playerIds[j])) continue;
                    sum += normalizedChances[j];
                    if (sum >= randomNumber) {
                        console.log("chance:" + normalizedChances[j] + players[j].name);
                        selectedPlayers.add(playerIds[j]);
                        pack.push(players[j]);
                        break;
                    }
                }
            }
            res.status(200).json(pack);
        })
        .catch(error => {
            console.error(error);
            res.status(500).json({ message: "Error generating pack" });
        });
}



