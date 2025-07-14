import 'dart:async';
import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  //Future<Database> get database async => await _dropDatabase();



  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'discountapp.db');
    // Delete the database
    //await deleteDatabase(path);//note iyi ngomba kuyi commentaho muri production itazajya isiba ibintu
    return await openDatabase(
        path,
        version: 1,//hano iyo uhinduye version noneho ugahita ushyiramo code muri onUpgrade
        onCreate: _onCreate,
        onUpgrade: _onUpgrade

    );
  }

  Future _onCreate(Database db, int version) async {

    await db.execute('''
      CREATE TABLE groceries(
          id INTEGER PRIMARY KEY,
          name TEXT
      )
      ''');
    await db.execute(''' 
    
CREATE TABLE `admins` (
`id` INTEGER  NOT NULL ,
`uid` TEXT  NOT NULL UNIQUE,
`photo_url` TEXT  NOT NULL DEFAULT 'none',
`name` TEXT  NOT NULL DEFAULT 'none',
`email` TEXT  NOT NULL DEFAULT 'none',
`password` TEXT  NOT NULL DEFAULT 'none',
`phone` TEXT  NOT NULL DEFAULT 'none',
`status` TEXT  NOT NULL DEFAULT 'none',
`platform` TEXT  NOT NULL DEFAULT 'none',
`CompanyName` TEXT  NOT NULL DEFAULT 'none',
`AuthToken` TEXT  NOT NULL DEFAULT 'none',
`subscriber` TEXT  NOT NULL DEFAULT 'none',
`country` TEXT  NOT NULL DEFAULT 'none',
`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`)
);



CREATE UNIQUE INDEX `admins_admins_uid_unique` ON `admins` (`uid`);
CREATE INDEX `admins_subscriber` ON `admins` (`subscriber`);


COMMIT;
PRAGMA ignore_check_constraints = ON;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;
 
     ''');
    await db.execute('''  
 
CREATE TABLE `users` (
`id` INTEGER  NOT NULL ,
`uid` TEXT  NOT NULL,
`carduid` TEXT  NOT NULL DEFAULT 'none',
`uidCreator` TEXT  NOT NULL,
`subscriber` TEXT  NOT NULL DEFAULT 'none',
`photo_url` TEXT  NOT NULL DEFAULT 'none',
`name` TEXT  NOT NULL DEFAULT 'none',
`email` TEXT  NOT NULL DEFAULT 'none',
`password` TEXT  NOT NULL DEFAULT 'none',
`phone` TEXT  NOT NULL DEFAULT 'none',
`platform` TEXT  NOT NULL DEFAULT 'none',
`status` TEXT  NOT NULL DEFAULT 'none',
`gender` TEXT  NOT NULL DEFAULT 'none',
`age` TEXT  NOT NULL DEFAULT 'none',
`country` TEXT  NOT NULL DEFAULT 'none',
`marital_status` TEXT  NOT NULL DEFAULT 'none',
`remember_token` TEXT  DEFAULT NULL,
`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`)
);



CREATE UNIQUE INDEX `users_users_uid_unique` ON `users` (`uid`);
CREATE INDEX `users_carduid` ON `users` (`carduid`);
CREATE INDEX `users_uidCreator` ON `users` (`uidCreator`);
CREATE INDEX `users_subscriber` ON `users` (`subscriber`);
CREATE INDEX `users_platform` ON `users` (`platform`);
CREATE INDEX `users_gender` ON `users` (`status`);
CREATE INDEX `users_status` ON `users` (`gender`);
CREATE INDEX `users_age` ON `users` (`age`);
CREATE INDEX `users_country` ON `users` (`country`);
CREATE INDEX `users_marital_status` ON `users` (`marital_status`);

COMMIT;
PRAGMA ignore_check_constraints = ON;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;
     ''');

    await db.execute('''  
    


CREATE TABLE `cards` (
`id` INTEGER  NOT NULL ,
`uid` TEXT  NOT NULL,
`uidCreator` TEXT  NOT NULL DEFAULT 'none',

`subscriber` TEXT  NOT NULL DEFAULT 'none',

`uidCreatorOnline` TEXT  NOT NULL DEFAULT 'none',

`subscriberOnline` TEXT  NOT NULL DEFAULT 'none',
`SyncAdd` TEXT  NOT NULL DEFAULT 'new',
`SyncUpdate` TEXT  NOT NULL DEFAULT 'new',

`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`)
);



CREATE INDEX `cards_uid` ON `cards` (`uid`);
CREATE INDEX `cards_uidCreator` ON `cards` (`uidCreator`);
CREATE INDEX `cards_subscriber` ON `cards` (`subscriber`);
CREATE INDEX `cards_uidCreatorOnline` ON `cards` (`uidCreatorOnline`);
CREATE INDEX `cards_subscriberOnline` ON `cards` (`subscriberOnline`);

CREATE INDEX `cards_SyncAdd` ON `cards` (`SyncAdd`);
CREATE INDEX `cards_SyncUpdate` ON `cards` (`SyncUpdate`);


COMMIT;
PRAGMA ignore_check_constraints = ON;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;

     ''');
    //on promotions there is missing of subscriber because it may be more company having different promotions
    await db.execute(''' 

CREATE TABLE `promotions` (
`id` INTEGER  NOT NULL ,
`uid` TEXT  NOT NULL,
`uidCreator` TEXT  NOT NULL,
`subscriber` TEXT  NOT NULL DEFAULT 'none',
`token` TEXT  NOT NULL DEFAULT 'none',
`promoName` TEXT  NOT NULL DEFAULT 'none',
`promo_msg` TEXT  NOT NULL DEFAULT 'none',
`reach` TEXT  NOT NULL DEFAULT 'none',
`gain` TEXT  NOT NULL DEFAULT 'none',
`type_service` TEXT  NOT NULL DEFAULT 'none',
`started_date` TEXT  NOT NULL DEFAULT 'none',
`ended_date` TEXT  NOT NULL DEFAULT 'none',
`status` TEXT  NOT NULL DEFAULT 'none',
`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`)
);



CREATE INDEX `promotions_uid` ON `promotions` (`uid`);
CREATE INDEX `promotions_uidCreator` ON `promotions` (`uidCreator`);
CREATE INDEX `promotions_subscriber` ON `promotions` (`subscriber`);
CREATE INDEX `promotions_token` ON `promotions` (`token`);
CREATE INDEX `promotions_promoName` ON `promotions` (`promoName`);
CREATE INDEX `promotions_promo_msg` ON `promotions` (`promo_msg`);
CREATE INDEX `promotions_reach` ON `promotions` (`reach`);
CREATE INDEX `promotions_gain` ON `promotions` (`gain`);
CREATE INDEX `promotions_started_date` ON `promotions` (`started_date`);
CREATE INDEX `promotions_ended_date` ON `promotions` (`ended_date`);
CREATE INDEX `promotions_status` ON `promotions` (`status`);

COMMIT;
PRAGMA ignore_check_constraints = ON;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;

     ''');
    await db.execute('''  
    
CREATE TABLE `participateds` (
`id` INTEGER  NOT NULL ,
`uid` TEXT  NOT NULL,
`uidUser` TEXT  NOT NULL,
`uidCreator` TEXT  NOT NULL DEFAULT 'none',
`subscriber` TEXT  NOT NULL DEFAULT 'none',
`promotion_msg` TEXT  NOT NULL DEFAULT 'none',
`inputData` TEXT  NOT NULL DEFAULT 'none',
`token` TEXT  NOT NULL DEFAULT 'none',
`started_date` TEXT  NOT NULL DEFAULT 'none',
`ended_date` TEXT  NOT NULL DEFAULT 'none',
`status` TEXT  NOT NULL DEFAULT 'none',
`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`)
);



CREATE INDEX `participateds_uid` ON `participateds` (`uid`);
CREATE INDEX `participateds_uidUser` ON `participateds` (`uidUser`);
CREATE INDEX `participateds_uidCreator` ON `participateds` (`uidCreator`);
CREATE INDEX `participateds_inputData` ON `participateds` (`inputData`);
CREATE INDEX `participateds_subscriber` ON `participateds` (`subscriber`);
CREATE INDEX `participateds_token` ON `participateds` (`token`);
CREATE INDEX `participateds_started_date` ON `participateds` (`started_date`);
CREATE INDEX `participateds_ended_date` ON `participateds` (`ended_date`);
CREATE INDEX `participateds_status` ON `participateds` (`status`);

COMMIT;
PRAGMA ignore_check_constraints = ON;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;

     ''');
    await db.execute('''  
    


CREATE TABLE `topups` (
`id` INTEGER  NOT NULL ,
`uid` TEXT  NOT NULL,
`uidCreator` TEXT  NOT NULL DEFAULT 'none',
`amount` TEXT  NOT NULL DEFAULT 'none',
`subscriber` TEXT  NOT NULL DEFAULT 'none',
`purpose` TEXT  NOT NULL DEFAULT 'none',
`desc` TEXT 
`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`)
);



CREATE INDEX `topups_uid` ON `topups` (`uid`);
CREATE INDEX `topups_uidCreator` ON `topups` (`uidCreator`);
CREATE INDEX `topups_subscriber` ON `topups` (`subscriber`);
CREATE INDEX `topups_purpose` ON `topups` (`purpose`);

COMMIT;
PRAGMA ignore_check_constraints = ON;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;

     ''');

    await db.execute('''  
    

CREATE TABLE `Syncon` (
`id` INTEGER  NOT NULL ,
`uid` TEXT  NOT NULL,
`versionCount` TEXT  NOT NULL DEFAULT '0',
`subscriber` TEXT  NOT NULL DEFAULT 'none',
`actionName` TEXT  NOT NULL DEFAULT 'none',
`tableName` TEXT  NOT NULL DEFAULT 'none',
`desc` TEXT 
`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`)
);



CREATE INDEX `Syncon_uid` ON `Syncon` (`uid`);
CREATE INDEX `Syncon_versionCount` ON `Syncon` (`versionCount`);
CREATE INDEX `Syncon_subscriber` ON `Syncon` (`subscriber`);
CREATE INDEX `Syncon_actionName` ON `Syncon` (`actionName`);
CREATE INDEX `Syncon_tableName` ON `Syncon` (`tableName`);

COMMIT;
PRAGMA ignore_check_constraints = ON;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;


     ''');

    await db.execute('''  
    

CREATE TABLE `Syncoff` (
`id` INTEGER  NOT NULL ,
`uid` TEXT  NOT NULL UNIQUE,
`versionCount` TEXT  NOT NULL DEFAULT '0',
`subscriber` TEXT  NOT NULL DEFAULT 'none',
`actionName` TEXT  NOT NULL DEFAULT 'none',
`tableName` TEXT  NOT NULL DEFAULT 'none',
`desc` TEXT 
`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`)
);




CREATE INDEX `Syncoff_versionCount` ON `Syncoff` (`versionCount`);
CREATE INDEX `Syncoff_subscriber` ON `Syncoff` (`subscriber`);
CREATE INDEX `Syncoff_actionName` ON `Syncoff` (`actionName`);
CREATE INDEX `Syncoff_tableName` ON `Syncoff` (`tableName`);

COMMIT;
PRAGMA ignore_check_constraints = ON;
PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;


     ''');


  }

  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // await db.execute("ALTER TABLE testdata ADD COLUMN bill TEXT;");

    }
  }





}