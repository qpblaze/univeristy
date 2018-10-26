/* exec.c

   Executia prin program a comenzii 'ls -a -l', folosind execlp()
   
   Autor: Sabin-Corneliu Buraga <busaco@infoiasi.ro> (c)1998-2001
   Versiunea: 1.0 (ultima actualizare: 04 iunie 2001)
*/
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>
    #include <sys/wait.h>


void main ()
{
  pid_t pid;			/* PID-ul procesului copil */
  int status;			/* starea de terminare a procesului copil */

  printf ("Vom executa comanda...\n");
 int read = 1;

  char url[256];

  if ((pid = fork ()) < 0)
  {
    perror ("fork()");
    exit (1);
  }
  else if (pid)			/* parinte */
  {
      printf("url: ");
      scanf("%s", url);
    if (wait (&status) < 0)
    {
      perror ("wait()");
    }
    printf ("Comanda a fost executata.\n");
    exit (0);
  }
  else				/* fiu */
  {
       
    execlp("wget",
        "wget",
      url,		/* argv[0] */
      NULL);
    printf ("Eroare de executie!\n");
    exit (1);
  }
    
  
}
