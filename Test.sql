-- department definition
SET search_path TO bd053_schema, public;


CREATE TABLE department (
    dept_name VARCHAR(20) PRIMARY KEY,
    building VARCHAR(15),
    budget NUMERIC(12,2)
);


-- course definition

CREATE TABLE course (
    course_id VARCHAR(8) PRIMARY KEY,
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credits NUMERIC(2,0),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);


-- instructor definition

CREATE TABLE instructor (
    ID VARCHAR(5) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC(8,2),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);


-- prereq definition

CREATE TABLE prereq (
    course_id VARCHAR(8),
    prereq_id VARCHAR(8),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);


-- "section" definition

CREATE TABLE section (
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4,0),
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);


-- student definition

CREATE TABLE student (
    ID VARCHAR(5) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    tot_cred NUMERIC(3,0) DEFAULT 0,
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

CREATE INDEX student_dept_idx on student (dept_name);


-- takes definition

CREATE TABLE takes (
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4,0),
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES student(ID),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year)
);


INSERT INTO department (dept_name,building,budget) VALUES
	 ('Comp. Sci.','Taylor',100000),
	 ('Biology','Watson',90000),
	 ('Physics','Taylor',85000),
	 ('History','Painter',50000);
INSERT INTO course (course_id,title,dept_name,credits) VALUES
	 ('BIO-101','Intro. to Biology','Biology',4),
	 ('BIO-301','Genetics','Biology',4),
	 ('CS-101','Intro. to Computer Science','Comp. Sci.',4),
	 ('CS-190','Game Design','Comp. Sci.',4),
	 ('CS-315','Robotics','Comp. Sci.',3),
	 ('CS-347','Database Concepts','Comp. Sci.',3),
	 ('PHY-101','Physical Principles','Physics',4),
	 ('HIS-351','World History','History',3),
	 ('t2','test','Comp. Sci.',3);
INSERT INTO instructor (ID,name,dept_name,salary) VALUES
	 ('10101','Srinivasan','Comp. Sci.',65000),
	 ('12121','Wu','Biology',90000),
	 ('15151','Mozart','Physics',40000),
	 ('22222','Einstein','Physics',95000),
	 ('32343','El Said','History',60000);
INSERT INTO prereq (course_id,prereq_id) VALUES
	 ('BIO-301','BIO-101'),
	 ('CS-190','CS-101'),
	 ('CS-347','CS-101');
INSERT INTO "section" (course_id,sec_id,semester,"year",building,room_number,time_slot_id) VALUES
	 ('CS-101','1','Fall',2017,'Taylor','3128','A'),
	 ('CS-347','1','Fall',2017,'Taylor','3128','B'),
	 ('BIO-101','1','Fall',2017,'Watson','120','C'),
    ('CS-190','2','Spring',2017,'Watson','120','C'),
	 ('PHY-101','1','Fall',2017,'Taylor','100','D');
INSERT INTO student (ID,name,dept_name,tot_cred) VALUES
	 ('00128','Zhang','Comp. Sci.',102),
	 ('12345','Shankar','Comp. Sci.',32),
	 ('19991','Brandt','History',80),
	 ('23121','Chavez','Biology',110),
	 ('98765','Bourikas','Biology',98);
INSERT INTO takes (ID,course_id,sec_id,semester,"year",grade) VALUES
	 ('00128','CS-101','1','Fall',2017,'A'),
	 ('00128','CS-347','1','Fall',2017,'A-'),
	 ('12345','CS-101','1','Fall',2017,'C'),
	 ('12345','CS-190','2','Spring',2017,'A'),
	 ('23121','BIO-101','1','Fall',2017,'C+'),
	 ('98765','CS-101','1','Fall',2017,'C-');