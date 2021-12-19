5.8 Дана строка, содержащая слова, разделенные одним или несколько разделительными символами (пробелами, табуляторами), в начале строки и в конце строки также могут находиться раздельные символы. Сформулировать новую строку, в которой слова исходной строки, состоящие из нечетного количества символов, разделяются одним пробелом. В начале строки и в конце строки не должно быть разделительных символов
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
5.10 Дана строка, содержащая слова, разделенные одним или несколько разделительными символами (пробелами, табуляторами), в начале строки и в конце строки также могут находиться раздельные символы. Сформулировать новую строку, в которой слова исходной строки, состоящие из четного количества символов, разделяются одним пробелом. В начале строки и в конце строки не должно быть разделительных символов
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
5.11 Дана строка, содержащая слова, разделенные одним или несколько разделительными символами (пробелами, табуляторами), в начале строки и в конце строки также могут находиться раздельные символы. Сформулировать новую строку, в которой символы в словах исходной строки записаны в обратном порядке и разделяются одним пробелом. В начале строки и в конце строки не должно быть разделительных символов
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
5.15 Дана строка, содержащая слова, разделенные одним или несколько разделительными символами (пробелами, табуляторами), в начале строки и в конце строки также могут находиться раздельные символы. Сформулировать новую строку, в которой слова исходной строки записаны в алфавитном порядке и разделяются одним пробелом. В начале строки и в конце строки не должно быть разделительных символов.
#include <stdio.h>

void work(char* from,char* to);

int main(){
	char from[256], to[256];
	while(printf("Enter string\n"),gets(from)){
		printf("Original:'%s'\n",from);
		work(from,to);
		printf("Result:'%s'\n",to);
	}
	return 0;
}

void sortStr(char* x,int n)
{
	int i,j,m;
	char tmp;
	for (i=0;i<n-1;i++)
	{
		for(j=i+1,m=i;j<n;j++)
			if (x[j] < x[m]) m=j;
		tmp = x[i];
		x[i]=x[m];
		x[m]=tmp;
	}
}

char* skipspace(char* p){
	while(*p=='\040' || *p=='\t') p++;
	return p;
}

char* skipword(char* p){
	while(*p && *p!='\040' && *p!='\t') p++;
	return p;
}

char* mystrcat(char* to, char* from)
{
      char* ret = to;
      while(*to++);
      to--;
      while(*to++ = *from++);
      return ret;
}

char* mystrncat(char* to, char* from, int n)
{
      int i;
      char* ret = to;
      while(*to++);
      to--;
      for (i=0;i<n;*to++ = *from++,i++);
      *to= '\0';
      return ret;
}

void mystrcpy(char* to, char* from)
{
     while(*to++ = *from++);
}

void work(char* from, char* to){
	int i,len;
	char* p;
	char c;
	for(i=0,mystrcpy(to,""),from=skipspace(from);*from;from=skipspace(from)){		
    	len = (p=skipword(from)) - from;
		sortStr(from,len);
		if (i++) mystrcat(to," "); 
		mystrncat(to,from,len);
		from=p;
		/*printf("%d '%c' '%c'\n",len,*from,*p);*/
	}
    }
