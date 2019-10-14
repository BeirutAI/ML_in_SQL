--Drop columns from 'Wrangle.train' and 'Wrangle.train'
--Drop features Ticket and Cabin if exists by altering the tables and droping the column


alter table Wrangle.train drop column if exists Ticket
alter table Wrangle.train drop column if exists Cabin

alter table Wrangle.test drop column if exists Ticket
alter table Wrangle.test drop column if exists Cabin
