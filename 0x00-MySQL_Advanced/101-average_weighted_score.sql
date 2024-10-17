-- Create the table to store the average weighted score if it doesn't exist
CREATE TABLE IF NOT EXISTS student_averages (
    id INT NOT NULL AUTO_INCREMENT,
    avg_weighted_score DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id)
);

-- Create the stored procedure
DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE total_weighted_score DECIMAL(10, 2) DEFAULT 0;
    DECLARE total_weight DECIMAL(10, 2) DEFAULT 0;
    DECLARE avg_weighted_score DECIMAL(10, 2) DEFAULT 0;
    
    -- Compute total weighted score and total weight
    SELECT SUM(score * weight), SUM(weight)
    INTO total_weighted_score, total_weight
    FROM students;

    -- Calculate the average weighted score
    IF total_weight > 0 THEN
        SET avg_weighted_score = total_weighted_score / total_weight;
    ELSE
        SET avg_weighted_score = 0;
    END IF;

    -- Insert the result into student_averages table
    INSERT INTO student_averages (avg_weighted_score)
    VALUES (avg_weighted_score);
END $$

DELIMITER ;
