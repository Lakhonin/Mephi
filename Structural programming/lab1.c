1.1 Дано натуральное число N, посчитать кол-во и сумму четных цифр в записи числа

#include <stdio.h>

int main()
{
	int n, k, s;
	for(;;)
	{
		printf(“Введите натуральное число\n”);
		scanf(“%d”,&n);
		if(n<=0) break;
		for(s=k=0; n>0; n/=10)
		{
			if(n%2 == 0)
			{
				s+=n%10;
				k++;
			}
		}
		printf(“Количество четных цифр = %d и их сумма = %d\n”, k, s);
	}
	return 0;
}

1.3 Дано натуральное число N, подсчитать количество и сумму нечетных цифр в записи числа.

#include <stdio.h>

int main()
{
	int n, k, s;
	for(;;)
	{
		printf(“Введите натуральное число\n”);
		scanf(“%d”,&n);
		if(n<=0) break;
		for(s=k=0; n>0; n/=10)
		{
			if(n%2 )
			{
				s+=n%10;
				k++;
			}
		}
		printf(“Количество четных цифр = %d и их сумма = %d\n”, k, s);
	}
	return 0;
}

1.10 Дано натуральное число N.  Уменьшить каждую цифру на единицу вместо нуля записывать девять. Посчитать количество цифр в числе.
  
#include <stdio.h>

int main() 
{
while (1) 
{
      	int x,n;
      	scanf("%d",&x);
          	if (x<=0) break;
          	int nx=0,p=1;
          	while (x>0) 
{
                		n=x%10;
                		if (n!=0) 
                   			nx=nx+(n-1)*p;
                		else
                  			nx=nx+9*p;
              			p*=10;
              			x/=10;  
          	}
          	printf("%d\n",nx);
    }
    return 0;
}
