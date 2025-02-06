
# User and Group Creation Script

This script allows for the creation of a new group, a new user within that group, setting the user's password, and creating a directory for the user with the appropriate permissions.

## Features

- **Create a new group**: The script checks if the group already exists before attempting to create it.
- **Create a new user**: It creates a new user and assigns them to the specified group, ensuring the user doesn't already exist.
- **Set a password for the user**: The script allows for setting a password for the newly created user.
- **Create a user-specific directory**: It creates a directory for the user with proper ownership and permissions, and sets the sticky bit to prevent deletion by other users.

## Requirements

- The script must be run as `root` (UID 0). It checks the current user and exits if not executed with root privileges.

## Usage

1. **Run the script**:
   ```bash
   sudo ./script_name.sh
   ```

2. **Input Prompts**:
   ```bash
   Enter a new group name: mygroup
   Group 'mygroup' created
   Enter a new username: myuser
   User 'myuser' created
   Password set for user 'myuser'
   Dir '/myuser' has been created for user 'myuser'
   Task completed
   ```

## Functions

### `g_exist`
Checks if a group exists by searching `/etc/group`.

### `user_exist`
Checks if a user exists by searching `/etc/passwd`.

### `create_g`
Creates a new group if it doesn't already exist.

### `create_user`
Creates a new user in the specified group if the user doesn't already exist.

### `set_passwd`
Sets the password for the specified user.

### `make_userDir`
Creates a directory for the user and sets appropriate permissions:
- Ownership: `username:groupname`
- Permissions: `770` (read/write/execute for owner and group)
- Sticky bit is set to prevent deletion by non-owners.

## Example

```bash
Enter a new group name: mygroup
Group 'mygroup' created
Enter a new username: myuser
User 'myuser' created
Password set for user 'myuser'
Dir '/myuser' has been created for user 'myuser'
Task completed
```

## Notes

- The script exits with an error message if a group or user already exists.
- It requires `root` privileges to run.
