create
database opencart;
create
database provdb;
use
provdb;
create table users
(
    id       int         not null auto_increment,
    username varchar(20) not null,
    password varchar(20) not null,
    primary key (id),
    unique key (username)
);