#include <stdio.h>

void main()
{
	FILE * f = fopen("testpak", "r");
	char[246] l = [];
	while(!feof(f))
	{
		fscanf(f, "%s", &l);
		printf("%s\n", l);
	}
}