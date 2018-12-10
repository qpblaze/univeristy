#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define MSG1 "Comunicam prin socketi!"
#define MSG2 "Atentie!Socketpair() o generalizarea a pipe-urilor"

int main()
{
    int sockp[2], parent;
    char msg[1024];

    if (socketpair(AF_UNIX, SOCK_STREAM, 0, sockp) < 0)
    {
        perror("Err... socketpair");
        exit(1);
    }

    if ((parent = fork()) == -1)
    {
        perror("Err...fork");
    }
    else
    {
        if (parent)   //parinte
        {
            close(sockp[0]);

            printf("[parinte] %s\n", msg);

            if (write(sockp[1], MSG2, sizeof(MSG2)) < 0)
            {
                perror("[parinte]Err...write");
            }

            close(sockp[1]);
        }
        else     //copil
        {
            close(sockp[1]);

            printf("child\n");
            if (write(sockp[0], MSG1, sizeof(MSG1)) < 0)
            {
                perror("[copil]Err...write");
            }

            if (read(sockp[0], msg, 1024) < 0)
            {
                perror("[copil]Err..read");
            }

            printf("[copil]  %s\n", msg);

            close(sockp[0]);
        }
    }
}