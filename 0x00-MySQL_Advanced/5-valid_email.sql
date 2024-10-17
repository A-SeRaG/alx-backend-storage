-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS email_change_reset;

-- Create the trigger
CREATE TRIGGER email_change_reset
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    -- Check if the email has changed
    IF NEW.email <> OLD.email THEN
        -- Reset valid_email to 0
        SET NEW.valid_email = 0;
    END IF;
END;
