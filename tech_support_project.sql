--Table creation

--Table Agent
create table Agents 
(agent_id int primary key, agent_name varchar(50), team varchar(50))

--Table Customer
create table Customers
(customer_id int primary key,customer_name varchar(50), city varchar(50))

--Table Tickets
create table Tickets
(ticket_id int primary key, customer_id int, agent_id int, 
 issue_type varchar(50),priority varchar(50), status varchar(50), created_date date,resolved_date date,
foreign key (customer_id) references Customers(customer_id),
foreign key (agent_id) references Agents(agent_id))


--Insert Data

--In Agents Table
insert into Agents values
(201,'Amit Sharma','Web'),
(202,'Neha Verma','Web'),
(203,'Rahul Singh','chat'),
(204,'Priya Das','Email')

--In Customers Table
insert into Customers values
(101, 'Rohan', 'Mumbai'),
(102, 'Anita', 'Delhi'),
(103, 'Karan', 'Pune'),
(104, 'Sneha', 'Bangalore'),
(105, 'Vikas', 'Nagpur'),
(106, 'Meera', 'Hyderabad'),
(107, 'Arjun', 'Chennai'),
(108, 'Pooja', 'Kolkata'),
(109, 'Raj', 'Ahmedabad'),
(110, 'Simran', 'Jaipur')

--In Tickets Table
insert into Tickets values
(1, 101, 201, 'Login Issue', 'High', 'Closed', '2024-01-01', '2024-01-02'),
(2, 102, 202, 'Payment Failure', 'High', 'Closed', '2024-01-02', '2024-01-04'),
(3, 103, 201, 'Account Locked', 'Medium', 'Closed', '2024-01-03', '2024-01-03'),
(4, 104, 203, 'Slow App', 'Low', 'Open', '2024-01-04', NULL),
(5, 105, 202, 'Refund Issue', 'High', 'Closed', '2024-01-05', '2024-01-06'),
(6, 106, 204, 'Login Issue', 'Medium', 'Closed', '2024-01-06', '2024-01-07'),
(7, 107, 203, 'Technical Error', 'High', 'Open', '2024-01-07', NULL),
(8, 108, 201, 'Payment Failure', 'Medium', 'Closed', '2024-01-08', '2024-01-09'),
(9, 109, 204, 'Account Locked', 'Low', 'Closed', '2024-01-09', '2024-01-10'),
(10, 110, 202, 'Slow App', 'Medium', 'Closed', '2024-01-10', '2024-01-12')


--checking for data inserted
select * from Agents
select * from Customers
select * from Tickets


--Scaling Data
insert into Tickets
select 
    ticket_id + (select max(ticket_id) from Tickets),
    customer_id,
    agent_id,
    issue_type,
    priority,
    status,
    created_date + INTERVAL '1 day',
    resolved_date + INTERVAL '1 day'
from Tickets;

select * from Tickets



--Combining tables for analysis

---Joining tickets with customers and agents to get complete dataset
select t.ticket_id, c.customer_name, a.agent_name, a.team as channel
from Tickets t
inner join Customers c 
on t.customer_id = c.customer_id
inner join Agents a 
on t.agent_id = a.agent_id



--Analyzing data and Getting Insights

--Counting tickets per channel using inner join
select a.team as channel, count(*) 
from Tickets t
inner join Agents a on t.agent_id = a.agent_id
group by a.team


--counting status of tickets (Open vs Closed)
select status, count(*)
from Tickets
group by status

---Analyzing tickets based on issue type
select issue_type, count(*)
from Tickets 
group by issue_type
order by count(*) desc --which issue appeared the most


---- Calculate average resolution time (ticket resolved in how may days)
select round(avg(resolved_date - created_date),2) as day --subtracting days
from Tickets
where status = 'Closed'


--Ticket count based on priority
select priority, count(*)
from Tickets
group by priority
order by count(*) desc


---- Priority vs Status
select priority, status, count(*) 
from Tickets
group by priority, status
order by priority








