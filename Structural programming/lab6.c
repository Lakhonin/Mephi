6.7 Дан двоичный файл, содержащий целые числа. Сформулировать текстовый файл, в котором эти числа записаны по одному в строке. Программа должна производить проверку особых ситуаций при операциях ввода-вывода.
#include <stdio.h>
int main()
{
char buf1[80],buf2[80];
FILE *f1,*f2;
int a;
while (printf("Enter binary filename\n"),gets(buf1)){
if ((f1=fopen(buf1,"r"))==NULL)
{
perror(buf1);
continue;
}
printf("Enter target filename\n");
gets(buf2);
if ((f2=fopen(buf2,"w"))==NULL)
{
perror(buf2);
continue;
}
while (fread(&a,sizeof(int),1,f1)==1)
{
printf("%d\n",a);
fprintf(f2,"%d\n",a);
if (ferror(f2))
{
perror(buf2);
fclose(f2);
return 1;
}
}
fclose(f1); fclose(f2);
}
return 0;
}
