CREATE TABLE `player_ammo` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`citizenid` VARCHAR(9) NOT NULL,
	`ammo_revolver` INT(3) NOT NULL DEFAULT '0',
	`ammo_revolver_express` INT(3) NOT NULL DEFAULT '0',
	`ammo_revolver_express_explosive` INT(3) NOT NULL DEFAULT '0',
	`ammo_revolver_high_velocity` INT(3) NOT NULL DEFAULT '0',
	`ammo_revolver_split_point` INT(3) NOT NULL DEFAULT '0',
	`ammo_pistol` INT(3) NOT NULL DEFAULT '0',
	`ammo_pistol_express` INT(3) NOT NULL DEFAULT '0',
	`ammo_pistol_express_explosive` INT(3) NOT NULL DEFAULT '0',
	`ammo_pistol_high_velocity` INT(3) NOT NULL DEFAULT '0',
	`ammo_pistol_split_point` INT(3) NOT NULL DEFAULT '0',
	`ammo_repeater` INT(3) NOT NULL DEFAULT '0',
	`ammo_repeater_express` INT(3) NOT NULL DEFAULT '0',
	`ammo_repeater_express_explosive` INT(3) NOT NULL DEFAULT '0',
	`ammo_repeater_high_velocity` INT(3) NOT NULL DEFAULT '0',
	`ammo_repeater_split_point` INT(3) NOT NULL DEFAULT '0',
	`ammo_rifle` INT(3) NOT NULL DEFAULT '0',
	`ammo_rifle_express` INT(3) NOT NULL DEFAULT '0',
	`ammo_rifle_express_explosive` INT(3) NOT NULL DEFAULT '0',
	`ammo_rifle_high_velocity` INT(3) NOT NULL DEFAULT '0',
	`ammo_rifle_split_point` INT(3) NOT NULL DEFAULT '0',
	`ammo_buckshot` INT(3) NOT NULL DEFAULT '0',
	`ammo_buckshot_incendiary` INT(3) NOT NULL DEFAULT '0',
	`ammo_slug` INT(3) NOT NULL DEFAULT '0',
	`ammo_slug_explosive` INT(3) NOT NULL DEFAULT '0',
	`ammo_rifle_elephant` INT(3) NOT NULL DEFAULT '0',
	`ammo_varmint` INT(3) NOT NULL DEFAULT '0',
	`ammo_tranquilizer` INT(3) NOT NULL DEFAULT '0',
	`ammo_arrow` INT(3) NOT NULL DEFAULT '0',
	`ammo_fire` INT(3) NOT NULL DEFAULT '0',
	`ammo_poison` INT(3) NOT NULL DEFAULT '0',
	`ammo_dynamite` INT(3) NOT NULL DEFAULT '0',
	`thrown_molotov` INT(3) NOT NULL DEFAULT '0',
	`thrown_tomahawk` INT(3) NOT NULL DEFAULT '0',
	`thrown_tomahawk_ancient` INT(3) NOT NULL DEFAULT '0',
	`thrown_dynamite` INT(3) NOT NULL DEFAULT '0',
	`thrown_poisonbottle` INT(3) NOT NULL DEFAULT '0',
	`thrown_knives` INT(3) NOT NULL DEFAULT '0',
	`thrown_bolas` INT(3) NOT NULL DEFAULT '0',
	`thrown_bolas_hawkmoth` INT(3) NOT NULL DEFAULT '0',
	`thrown_bolas_intertwined` INT(3) NOT NULL DEFAULT '0',
	`thrown_bolas_ironspiked` INT(3) NOT NULL DEFAULT '0',
	`thrown_hatchet` INT(3) NOT NULL DEFAULT '0',
	`thrown_hatchet_hunter` INT(3) NOT NULL DEFAULT '0',
	`thrown_hatchet_cleaver` INT(3) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	UNIQUE INDEX `citizenid` (`citizenid`),
	CONSTRAINT `FK_player_ammo_players` FOREIGN KEY (`citizenid`) REFERENCES `players` (`citizenid`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1;
