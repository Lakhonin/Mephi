4.8 Дана строка, содержащая слова, разделенные одним или несколько разделительными символами (пробелами, табуляторами), в начале строки и в конце строки также могут находиться раздельные символы. Сформулировать новую строку, в которой слова исходной строки, состоящие из нечетного количества символов, разделяются одним пробелом. В начале строки и в конце строки не должно быть разделительных символов
#include <stdio.h>
#include <string.h>
#include <ctype.h>

void work(char*,char*);

int main()
{
	char src[80], dst[80];
	while(printf(“Введите строку:”),gets(src))
	{
		printf(“Исходная строка:’%s’\n”,src);
		work(src,dst);
		printf(“Результат:’%s’\n”,dst);
	}
	return 0;
}

void work(char *in, char *out)
{
	int i;
	for(strcpy(out,””); *(in+=strspn(in,” \t”)); in+=i)
	{
		i=strcspn(in,” \t”);
		if(i%2==1)
		{
			if(strlen(out))
			strcat(out,” “);
			strncat(out, in, i);
		}
	}
}
4.10 Дана строка, содержащая слова, разделенные одним или несколько разделительными символами (пробелами, табуляторами), в начале строки и в конце строки также могут находиться раздельные символы. Сформулировать новую строку, в которой слова исходной строки, состоящие из четного количества символов, разделяются одним пробелом. В начале строки и в конце строки не должно быть разделительных символов
#include <stdio.h>
#include <string.h>
#include <ctype.h>

void work(char*,char*);

int main()
{
	char src[80], dst[80];
	while(printf(“Введите строку:”),gets(src))
	{
		printf(“Исходная строка:’%s’\n”,src);
		work(src,dst);
		printf(“Результат:’%s’\n”,dst);
	}
	return 0;
}

void work(char *in, char *out)
{
	int i;
	for(strcpy(out,””); *(in+=strspn(in,” \t”)); in+=i)
	{
		i=strcspn(in,” \t”);
		if(i%2==0)
		{
			if(strlen(out))
			strcat(out,” “);
			strncat(out, in, i);
		}
	}
}
4.11 Дана строка, содержащая слова, разделенные одним или несколько разделительными символами (пробелами, табуляторами), в начале строки и в конце строки также могут находиться раздельные символы. Сформулировать новую строку, в которой символы в словах исходной строки записаны в обратном порядке и разделяются одним пробелом. В начале строки и в конце строки не должно быть разделительных символов
#include <stdio.h>
#include <string.h>
#include <ctype.h>

void work(char*,char*);

int main()
{
	char src[80], dst[80];
	while(printf(“Введите строку:”),gets(src))
	{
		printf(“Исходная строка:’%s’\n”,src);
		work(src,dst);
		printf(“Результат:’%s’\n”,dst);
	}
	return 0;
}

void work(char *in, char *out)
{
	int i, j;
	for(stcpy(out,””); *(in+=strspn(in,” \t”)); in+=j)
	{
		if(strlen(out))
		strcat(out,” “);
			j=strcspn(in,” \t”);
		i=j-1;
		for(; i>=0; i--)
		{
			strncat(out, in+i, 1);
		}
	}
}
