#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <dlfcn.h>
#include <dirent.h>
#include <sys/stat.h>

#ifdef __APPLE__
#include <crt_externs.h>
#define environ (*_NSGetEnviron())
#else
extern char **environ;
#endif

char **system_environ(void)
{
  return environ;
}

/* Adapted from the SBCL run-time system, which in turn is derived
 * from the CMU CL system, which was written at Carnegie Mellon
 * University and released into the public domain.
 */
int system_spawn(char *program, char **argv, char **envp, char *dir,
                 int inherit_console,
                 int stdin_fd, int stdout_fd, int stderr_fd)
{
  int pid = vfork();
  int fd;
  sigset_t sset;

  if (pid != 0)
    return pid;

  if (dir) {
    /* Set a new working directory */
    if (chdir(dir) != 0)
      _exit(127);
  }

  if (!inherit_console) {
    /* Put us in our own process group. */
    setsid();
  }

  /* unblock signals */
  sigemptyset(&sset);
  sigprocmask(SIG_SETMASK, &sset, NULL);

  /* Set up stdin, stdout, and stderr */
  if (stdin_fd >= 0)
    dup2(stdin_fd, 0);
  if (stdout_fd >= 0)
    dup2(stdout_fd, 1);
  if (stderr_fd >= 0)
    dup2(stderr_fd, 2);

  /* Close all other fds. */
  for (fd = sysconf(_SC_OPEN_MAX) - 1; fd > 2; fd--)
    close(fd);

  /* Exec the program. */
  execve(program, argv, envp);

  /* The exec didn't work, flame out. */
  _exit(127);
}

void *system_dlopen(const char *name)
{
  return dlopen(name, RTLD_NOW | RTLD_GLOBAL);
}

DIR *system_opendir(const char *dirname)
{
  return opendir(dirname);
}

int system_closedir(DIR *dirp)
{
  return closedir(dirp);
}

struct dirent *system_readdir(DIR *dirp)
{
  return readdir(dirp);
}

const char *system_dirent_name(struct dirent *dirent)
{
  return dirent->d_name;
}

int system_stat(const char* path, struct stat* buf)
{
  return stat(path, buf);
}
