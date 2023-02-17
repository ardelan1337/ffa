CREATE TABLE `ffa` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `kills` int(255) NOT NULL DEFAULT 0,
  `deaths` int(255) NOT NULL DEFAULT 0,
  `isinffa` int(255) DEFAULT 0,
  `identifier` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `ffa`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `ffa`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;