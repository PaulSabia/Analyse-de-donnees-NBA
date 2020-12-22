-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 15, 2020 at 02:02 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nba`
--

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `game_date` date NOT NULL,
  `game_id` int(11) NOT NULL,
  `games_status` varchar(20) NOT NULL,
  `home_team_id` int(11) NOT NULL,
  `visitor_team_id` int(11) NOT NULL,
  `season` year(4) NOT NULL,
  `pts_home` int(11) NOT NULL,
  `fg_pct_home` int(11) NOT NULL,
  `ft_pct_home` int(11) NOT NULL,
  `fg3_pct_home` int(11) NOT NULL,
  `ast_home` int(11) NOT NULL,
  `reb_hom` int(11) NOT NULL,
  `pts_away` int(11) NOT NULL,
  `fg_pct_away` int(11) NOT NULL,
  `ft_pct_away` int(11) NOT NULL,
  `fg3_pct_away` int(11) NOT NULL,
  `ast_away` int(11) NOT NULL,
  `reb_away` int(11) NOT NULL,
  `home_team_win` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `games_details`
--

CREATE TABLE `games_details` (
  `game_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `min` varchar(50) NOT NULL,
  `fgm` int(11) NOT NULL,
  `fga` int(11) NOT NULL,
  `fg3m` int(11) NOT NULL,
  `fg3a` int(11) NOT NULL,
  `ftm` int(11) NOT NULL,
  `fta` int(11) NOT NULL,
  `oreb` int(11) NOT NULL,
  `dreb` int(11) NOT NULL,
  `ast` int(11) NOT NULL,
  `stl` int(11) NOT NULL,
  `blk` int(11) NOT NULL,
  `turn_over` int(11) NOT NULL,
  `pfouls` int(11) NOT NULL,
  `pts` int(11) NOT NULL,
  `plus_minus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `player_name` varchar(50) NOT NULL,
  `player_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player_team`
--

CREATE TABLE `player_team` (
  `team_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `season` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ranking`
--

CREATE TABLE `ranking` (
  `team_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `conference` varchar(15) NOT NULL,
  `win` int(11) NOT NULL,
  `lose` int(11) NOT NULL,
  `home_record` varchar(20) NOT NULL,
  `road_record` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `team_id` int(11) NOT NULL,
  `min_year` year(4) NOT NULL,
  `abreviation` varchar(5) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `city` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`game_id`),
  ADD KEY `home_team_id` (`home_team_id`),
  ADD KEY `visitor_team_id` (`visitor_team_id`);

--
-- Indexes for table `games_details`
--
ALTER TABLE `games_details`
  ADD PRIMARY KEY (`game_id`,`player_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`player_id`);

--
-- Indexes for table `player_team`
--
ALTER TABLE `player_team`
  ADD KEY `teams_players_fk` (`team_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `ranking`
--
ALTER TABLE `ranking`
  ADD PRIMARY KEY (`season_id`,`team_id`),
  ADD KEY `teams_ranking_fk` (`team_id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`team_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `game_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `games`
--
ALTER TABLE `games`
  ADD CONSTRAINT `games_ibfk_1` FOREIGN KEY (`home_team_id`) REFERENCES `teams` (`team_id`),
  ADD CONSTRAINT `games_ibfk_2` FOREIGN KEY (`visitor_team_id`) REFERENCES `teams` (`team_id`);

--
-- Constraints for table `games_details`
--
ALTER TABLE `games_details`
  ADD CONSTRAINT `games_details_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`),
  ADD CONSTRAINT `games_games_details_fk` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `player_team`
--
ALTER TABLE `player_team`
  ADD CONSTRAINT `player_team_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`),
  ADD CONSTRAINT `teams_players_fk` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ranking`
--
ALTER TABLE `ranking`
  ADD CONSTRAINT `teams_ranking_fk` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
