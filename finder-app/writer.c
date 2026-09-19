#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <errno.h>
#include <string.h>

int main(int argc, char *argv[])
{
    // Open syslog connection with process ID and user facility
    openlog("writer", LOG_PID, LOG_USER);

    // Validate command line arguments (expected: program_name writefile writestr)
    if (argc != 3) {
        syslog(LOG_ERR, "Error: Invalid number of arguments. Usage: %s <file_path> <string_to_write>", argv[0]);
        closelog();
        return 1;
    }

    const char *filepath = argv[1];
    const char *writestr = argv[2];

    // Open target file for writing (create if not exists, truncate if exists)
    FILE *file = fopen(filepath, "w");
    if (file == NULL) {
        syslog(LOG_ERR, "Error opening file %s: %s", filepath, strerror(errno));
        closelog();
        return 1;
    }

    // Write the specified string to the file
    if (fputs(writestr, file) == EOF) {
        syslog(LOG_ERR, "Error writing string to file %s: %s", filepath, strerror(errno));
        fclose(file);
        closelog();
        return 1;
    }

    // Log informational message on success
    syslog(LOG_INFO, "Writing %s to %s", writestr, filepath);

    // Clean up resources
    fclose(file);
    closelog();

    return 0;
}
