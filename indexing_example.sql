-- creating table 
create table test_indexing(id serial, name text);

-- insert data into table
insert into test_indexing(name) select 'bob' from generate_series(1,250000);

insert into test_indexing(name) select 'alice' from generate_series(1,250000);

-- check the result before index
explain analyze
select * from test_indexing where id = 2;

-- create index
create index test_idx_ebac on test_indexing(id);

-- check the result after index
explain analyze select * from test_indexing where id = 2;
