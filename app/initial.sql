drop table if exists users cascade;
drop table if exists vehicles cascade;

create table users
(
    id       serial not null
        constraint users_pkey
            primary key,
    username varchar,
    password varchar
);

alter table users
    owner to root;

create index ix_users_id
    on users (id);

create unique index ix_users_username
    on users (username);

create table vehicles
(
    id       serial not null
        constraint vehicles_pkey
            primary key,
    distance integer,
    owner_id integer
        constraint vehicles_owner_id_fkey
            references users
);

alter table vehicles
    owner to root;

create index ix_vehicles_distance
    on vehicles (distance);

create index ix_vehicles_id
    on vehicles (id);

INSERT INTO users VALUES(1, 'user1','pass1');
INSERT INTO users VALUES(2, 'user2','pass2');
INSERT INTO users VALUES(3, 'user3','pass3');
INSERT INTO users VALUES(4, 'user4','pass4');
INSERT INTO users VALUES(5, 'user5','pass5');

INSERT INTO vehicles (id,distance,owner_id) VALUES(1,7051,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(2,4199,1);
INSERT INTO vehicles (id,distance,owner_id) VALUES(3,2966,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(4,6876,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(5,3640,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(6,8635,3);
INSERT INTO vehicles (id,distance,owner_id) VALUES(7,6041,1);
INSERT INTO vehicles (id,distance,owner_id) VALUES(8,7740,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(9,6323,1);
INSERT INTO vehicles (id,distance,owner_id) VALUES(10,6947,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(11,3528,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(12,5661,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(13,5375,3);
INSERT INTO vehicles (id,distance,owner_id) VALUES(14,3559,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(15,5373,3);
INSERT INTO vehicles (id,distance,owner_id) VALUES(16,4509,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(17,8662,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(18,5085,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(19,7613,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(20,6935,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(21,7527,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(22,6022,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(23,5347,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(24,5961,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(25,5034,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(26,8062,1);
INSERT INTO vehicles (id,distance,owner_id) VALUES(27,5602,1);
INSERT INTO vehicles (id,distance,owner_id) VALUES(28,6753,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(29,3760,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(30,5453,3);
INSERT INTO vehicles (id,distance,owner_id) VALUES(31,4475,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(32,9380,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(33,8636,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(34,4439,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(35,2595,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(36,5127,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(37,5785,3);
INSERT INTO vehicles (id,distance,owner_id) VALUES(38,6998,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(39,8537,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(40,3306,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(41,3355,1);
INSERT INTO vehicles (id,distance,owner_id) VALUES(42,2664,2);
INSERT INTO vehicles (id,distance,owner_id) VALUES(43,3677,1);
INSERT INTO vehicles (id,distance,owner_id) VALUES(44,2732,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(45,9987,4);
INSERT INTO vehicles (id,distance,owner_id) VALUES(46,9886,5);
INSERT INTO vehicles (id,distance,owner_id) VALUES(47,6837,3);
INSERT INTO vehicles (id,distance,owner_id) VALUES(48,4414,3);
INSERT INTO vehicles (id,distance,owner_id) VALUES(49,8328,5);