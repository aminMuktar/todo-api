-- Use the keyspace
USE todoapp;

-- Insert users
INSERT INTO users (user_id, username, email, created_at, updated_at) VALUES ('ba8a2dee-ca8e-47a6-afde-de57a7f04ef1', 'John', 'John@example.com', toTimestamp(now()), toTimestamp(now()));
INSERT INTO users (user_id, username, email, created_at, updated_at) VALUES ('cc633891-6873-4916-b60e-8a1a9a17ba04', 'Jane', 'Jane@example.com', toTimestamp(now()), toTimestamp(now()));
INSERT INTO users (user_id, username, email, created_at, updated_at) VALUES ('954f522c-5fcb-41ed-9258-53353ab808a2', 'Dana', 'Dana@example.com', toTimestamp(now()), toTimestamp(now()));
INSERT INTO users (user_id, username, email, created_at, updated_at) VALUES ('995de4f3-219b-457d-93c3-71832f534f77', 'Damon', 'Damon@example.com', toTimestamp(now()), toTimestamp(now()));
INSERT INTO users (user_id, username, email, created_at, updated_at) VALUES ('9deb0bbd-62c2-490c-a136-6dd67186d443', 'Stefan', 'Stefan@example.com', toTimestamp(now()), toTimestamp(now()));

-- Insert todos
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('09cb06bc-0f98-46af-9f57-b51521fc5a2e', 'ba8a2dee-ca8e-47a6-afde-de57a7f04ef1', 'Grocery Shopping', 'Buy milk, bread, eggs, and fruits', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('9ecb3c2f-ffae-4722-8594-7b5fb219f265', 'ba8a2dee-ca8e-47a6-afde-de57a7f04ef1', 'Laundry', 'Wash and fold clothes', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('9d89e721-778c-4c1c-a77a-54b1e93fe1f0', 'ba8a2dee-ca8e-47a6-afde-de57a7f04ef1', 'Workout', 'Morning gym session', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('bdd82003-84cd-4ad7-a63a-410350385d78', 'ba8a2dee-ca8e-47a6-afde-de57a7f04ef1', 'Read Book', 'Read 50 pages of a novel', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('66dfb998-b62b-4d1a-b941-9a1a7071576b', 'ba8a2dee-ca8e-47a6-afde-de57a7f04ef1', 'Call Mom', 'Weekly check-in call with mom', 'Pending', toTimestamp(now()), toTimestamp(now()));

INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('ee23cfe0-cfbd-4b59-b9d1-c6f04b6b252d', 'cc633891-6873-4916-b60e-8a1a9a17ba04', 'Project Meeting', 'Discuss project updates with team', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('5d345460-9611-44d5-8332-28b87804043a', 'cc633891-6873-4916-b60e-8a1a9a17ba04', 'Prepare Presentation', 'Prepare slides for client meeting', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('c16dd58c-9c65-4e60-8ff4-5da713b77071', 'cc633891-6873-4916-b60e-8a1a9a17ba04', 'Doctor Appointment', 'Annual check-up appointment', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('c8e8da80-624f-4b4f-9da3-e5175e2ad5a6', 'cc633891-6873-4916-b60e-8a1a9a17ba04', 'Dentist Appointment', 'Dental cleaning session', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('16de1453-bcfb-4462-85dd-ea874582cacb', 'cc633891-6873-4916-b60e-8a1a9a17ba04', 'Renew License', 'Renew drivers license online', 'Pending', toTimestamp(now()), toTimestamp(now()));

INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('8763aced-eb82-4479-a700-6ea4e70cf359', '954f522c-5fcb-41ed-9258-53353ab808a2', 'Finish Assignment', 'Complete the math assignment', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('16404b2b-643e-4df5-9525-c8bac8c4bfc6', '954f522c-5fcb-41ed-9258-53353ab808a2', 'Grocery Shopping', 'Buy vegetables and fruits', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('9a854684-743b-4ef3-9d2f-9a4b213edab4', '954f522c-5fcb-41ed-9258-53353ab808a2', 'Laundry', 'Wash and iron clothes', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('6b94670f-bfb7-4304-8be8-dcda6457589d', '954f522c-5fcb-41ed-9258-53353ab808a2', 'Cook Dinner', 'Prepare pasta for dinner', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('1d8a6a13-1ded-408d-9f38-554f65fca586', '954f522c-5fcb-41ed-9258-53353ab808a2', 'Gym', 'Evening workout session', 'Pending', toTimestamp(now()), toTimestamp(now()));

INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('4f2ba193-e1b0-4963-81d6-dd8832053eb6', '995de4f3-219b-457d-93c3-71832f534f77', 'Study', 'Read 2 chapters of the textbook', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('ba8a2dee-ca8e-47a6-afde-de57a7f04ef1', '995de4f3-219b-457d-93c3-71832f534f77', 'Clean Room', 'Vacuum and organize the room', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('cc633891-6873-4916-b60e-8a1a9a17ba04', '995de4f3-219b-457d-93c3-71832f534f77', 'Write Blog Post', 'Write a blog post on recent travel', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('954f522c-5fcb-41ed-9258-53353ab808a2', '995de4f3-219b-457d-93c3-71832f534f77', 'Plan Trip', 'Plan itinerary for weekend trip', 'Pending', toTimestamp(now()), toTimestamp(now()));
INSERT INTO todos (id, user_id, title, description, status, created, updated) VALUES ('995de4f3-219b-457d-93c3-71832f534f77', '995de4f3-219b-457d-93c3-71832f534f77', 'Attend Webinar', 'Join webinar on software development', 'Pending', toTimestamp(now()), toTimestamp(now()));