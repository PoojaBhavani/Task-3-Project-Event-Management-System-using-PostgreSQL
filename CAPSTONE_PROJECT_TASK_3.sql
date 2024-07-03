/*Create a database named "EventsManagement."*/
CREATE DATABASE EventsManagement;

/*Create tables for Events, Attendees, and Registrations.*/
CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name VARCHAR(100) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);

SELECT * FROM Events;

CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,
    Attendee_Name VARCHAR(100) NOT NULL,
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(100),
    Attendee_City VARCHAR(50)
);

SELECT * FROM Attendees;

CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,
    Event_Id INT REFERENCES Events(Event_Id),
    Attendee_Id INT REFERENCES Attendees(Attendee_Id),
    Registration_Date DATE NOT NULL,
    Registration_Amount DECIMAL(10, 2)
);

SELECT * FROM Registrations;

/*Insert some sample data for Events, Attendees, and Registrations tables with 
respective fields.*/

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description) VALUES
('TechSpark Summit', '2024-08-02', 'Los Angeles', 'A conference offers valuable insights and networking opportunities.'),
('WonderFest', '2024-11-01', 'New York', 'A festival featuring creative arts.'),
('Fitness Frenzy', '2024-09-15', 'San Francisco', 'A festival showcasing wellness on a sunny day promising high-energy activities.');

SELECT * FROM Events;

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) VALUES
('Edward Henry', '745-754-3651', 'edward.henry@gmail.com', 'Los Angeles'),
('Charles Beatrice', '124-852-7575', 'charles.beatrice@gmail.com', 'New York'),
('Albert Alastair', '456-777-9857', 'albert.alastair@gmail.com', 'San Francisco');

SELECT * FROM Attendees;

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount) VALUES
(1, 1, '2024-07-25', 500.00),
(2, 2, '2024-08-02', 450.00),
(3, 3, '2024-07-31', 600.00);

SELECT * FROM Attendees;

/*Inserting a new event.*/

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description) VALUES
('Groove Gala Music Festival', '2024-12-10', 'Chicago', 'A festival featuring various music artists.');

SELECT * FROM Events;

/*Updating an event's information.*/

UPDATE Events
SET Event_Location = 'Switzerland',
Event_Date = '2024-09-17'
WHERE Event_Id = 3;

SELECT * FROM Events;

-- Identify and remove duplicate events, keeping only one instance of each
WITH DuplicateEvents AS (
    SELECT MIN(event_id) AS keep_id
    FROM Events
    GROUP BY event_name, event_date, event_location, event_description
),
AllEvents AS (
    SELECT event_id
    FROM Events
)
DELETE FROM Events
WHERE event_id IN (
    SELECT event_id
    FROM AllEvents
    WHERE event_id NOT IN (SELECT keep_id FROM DuplicateEvents)
);

-- Verify the remaining events
SELECT * FROM Events;

/*Deleting an event.*/
Delete From Registrations
Where Event_Id=3;
DELETE FROM Events
WHERE Event_Id =3;

SELECT * FROM Events;

/*Inserting a new attendee.*/
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) VALUES
('Oliver Brown', '456-515-7866', 'oliver.brown@gmail.com', 'Italy');

SELECT * FROM Attendees;

/*Registering an attendee for an event*/
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount) VALUES
(1, 4, '2024-07-24', 500.00);

SELECT * FROM Registrations;

/*Develop queries to retrieve event information, generate attendee lists, and calculate event
attendance statistics.*/

/*Retrieve All Events*/

SELECT * FROM Events;

/*Generate Attendee List for a Specific Event*/
SELECT A.Attendee_Name, A.Attendee_Email, A.Attendee_Phone, A.Attendee_City
FROM Attendees A
JOIN Registrations R ON A.Attendee_Id = R.Attendee_Id
WHERE R.Event_Id = 2;

/*Calculate Event Attendance Statistics*/
SELECT E.Event_Name, COUNT(R.Registration_Id) AS Total_Attendees, SUM(R.Registration_Amount) AS Total_Amount
FROM Events E
JOIN Registrations R ON E.Event_Id = R.Event_Id
GROUP BY E.Event_Name;