CREATE DATABASE depo CHARACTER SET utf8; 

USE depo; 

CREATE TABLE bus_park 
  ( 
     id          INT auto_increment NOT NULL, 
     place       VARCHAR(255) NOT NULL, 
     max_count   INT NOT NULL, 
     PRIMARY KEY (id), 
     UNIQUE KEY (place) 
  ); 

CREATE TABLE waybill 
  ( 
     id         INT auto_increment NOT NULL, 
     num        INT NOT NULL, 
     issue_date DATE NOT NULL, 
     PRIMARY KEY (id) 
  ); 

CREATE TABLE route 
  ( 
     id  INT auto_increment NOT NULL, 
     num INT NOT NULL, 
     PRIMARY KEY (id), 
     UNIQUE KEY (num) 
  ); 

CREATE TABLE repair_shop 
  ( 
     id          INT auto_increment NOT NULL, 
     place       VARCHAR(255) NOT NULL, 
     max_count   INT NOT NULL, 
     PRIMARY KEY (id), 
     UNIQUE KEY (place) 
  ); 

CREATE TABLE stop_point 
  ( 
     id       INT auto_increment NOT NULL, 
     name     VARCHAR(255) NOT NULL,  
     PRIMARY KEY (id)
  ); 

CREATE TABLE schedule 
  ( 
     id            INT auto_increment NOT NULL, 
     schedule_time TIME NOT NULL, 
     route_id      INT NOT NULL, 
     stop_point_id INT NOT NULL, 
     PRIMARY KEY (id), 
     FOREIGN KEY (route_id) REFERENCES route(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT, 
     FOREIGN KEY (stop_point_id) REFERENCES stop_point(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT, 
     UNIQUE KEY time_route (schedule_time, route_id), 
     UNIQUE KEY route_stop (route_id, stop_point_id) 
  ); 

CREATE TABLE trans_depo 
  ( 
     id             INT auto_increment NOT NULL, 
     director       VARCHAR(255) NOT NULL, 
     place          VARCHAR(255) NOT NULL, 
     name           VARCHAR(255) NOT NULL, 
     waybill_id     INT NOT NULL, 
     bus_park_id    INT NOT NULL, 
     repair_shop_id INT NOT NULL, 
     PRIMARY KEY (id), 
     UNIQUE KEY (place), 
     UNIQUE KEY (name), 
     UNIQUE KEY (waybill_id), 
     UNIQUE KEY (bus_park_id), 
     UNIQUE KEY (repair_shop_id), 
     FOREIGN KEY (waybill_id) REFERENCES waybill(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT, 
     FOREIGN KEY (bus_park_id) REFERENCES bus_park(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT, 
     FOREIGN KEY (repair_shop_id) REFERENCES repair_shop(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT
  ); 

CREATE TABLE bus_driver 
  ( 
     id            INT auto_increment NOT NULL, 
     name          VARCHAR(255) NOT NULL, 
     sign_date     DATE NOT NULL, 
     trans_depo_id INT NOT NULL, 
     waybill_id    INT NOT NULL,
     PRIMARY KEY (id), 
     FOREIGN KEY (trans_depo_id) REFERENCES trans_depo(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
     FOREIGN KEY (waybill_id) REFERENCES waybill(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT
  ); 

CREATE TABLE bus_checker 
  ( 
     id            INT auto_increment NOT NULL, 
     name          VARCHAR(255) NOT NULL, 
     trans_depo_id INT NOT NULL, 
     PRIMARY KEY (id), 
     FOREIGN KEY (trans_depo_id) REFERENCES trans_depo(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT
  ); 

CREATE TABLE bus 
  ( 
     id          INT auto_increment NOT NULL, 
     num         INT NOT NULL, 
     num_region  INT NOT NULL,
     driver_id   INT NOT NULL, 
     checker_id  INT NOT NULL, 
     bus_park_id INT NOT NULL, 
     route_id    INT NOT NULL, 
     PRIMARY KEY (id), 
     UNIQUE KEY (num), 
     UNIQUE KEY (driver_id), 
     UNIQUE KEY (checker_id), 
     FOREIGN KEY (driver_id) REFERENCES bus_driver(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
     FOREIGN KEY (checker_id) REFERENCES bus_checker(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
     FOREIGN KEY (bus_park_id) REFERENCES bus_park(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT, 
     FOREIGN KEY (route_id) REFERENCES route(id) 
      ON UPDATE CASCADE
      ON DELETE RESTRICT
  ); 