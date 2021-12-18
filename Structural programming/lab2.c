2.1 Дано вещественное число x в заданном диапазоне. Вычислить сумму N членов ряда. Вычислить значение библиотечной функции sin(x). Полученные результаты вывести на экран для сравнения
#include <stdio.h>
#include <math.h>

int main()
{
  int i,n;
  double x,s,z;
  for(;;)
  {
    printf(“Введите количество чисел ряда\n”);
    scanf(“%d”,&n);
    if(n<=0) break;
    printf(“Введите вещественное число\n”);
    scanf(“%lf “,&x);
    for(i=1,s=z=x; i<=n; i++)
    {
      s+=-x*x/(2*i*(2*i+1));
    }
    printf(“sin(%f)=%f, s=%f\n”,x,sin(x),s);
  }
  return 0;
}

2.2 Дано вещественное число x в заданном диапазоне. Вычислить сумму N членов ряда. Вычислить значение библиотечной функции sinh(x). Полученные результаты вывести на экран для сравнения.
#include <stdio.h>
#include <math.h>

int main()
{
  int i,n;
  double x,s,z;
  for(;;)
  {
    printf(“Введите количество чисел ряда\n”);
    scanf(“%d”,&n);
    if(n<=0) break;
    printf(“Введите вещественное число\n”);
    scanf(“%lf “,&x);
    for(i=1,s=z=x; i<=n; i++)
    {
	    z=z*x*x/((2*i+1)*(2*i));
      s+=z;
    }
    printf(“sinh(%lf)=%lf, s=%lf\n”, x, sinh(x), s);
  }
  return 0;
}
2.5 Дано вещественное число x в заданном диапазоне. Вычислить сумму N членов ряда. Вычислить значение библиотечной функции exp(x). Полученные результаты вывести на экран для сравнения.
#include <stdio.h>
#include <math.h>

int main()
  {
    int i,n,f;
    double x,s,z;
    for(;;)
    {
      printf(“Введите количество чисел ряда\n”);
      scanf(“%d”,&n);
      if(n<=0) break;
      printf(“Введите вещественное число\n”);
      scanf(“%lf “,&x);
      for(i=0,s=0,f=1,p=1;i<=n;p*=x,f*=++i)
      {
	      s+=p/f
      }
      printf(“exp(%lf)=%lf, s=%lf\n”, x, exp(x), s);
    }
    return 0;
}
2.6 Дано вещественное число x в заданном диапазоне. Вычислить сумму N членов ряда. Вычислить значение библиотечной функции log(1+x). Полученные результаты вывести на экран для сравнения.
#include <stdio.h>
#include <math.h>

int main()
{
  int i,n,f,m;
  double x,s,z;
  for(;;)
  {
    printf(“Введите количество чисел ряда\n”);
    scanf(“%d”,&n);
    if(n<=0) break;
    printf(“Введите вещественное число\n”)
    scanf(“%lf “,&x);
    for(i=1,s=0, p=-1; i<=n;i++)
    {
	    s+=(p*=-x)/i;
    }
    printf(“log(1+(%f))=%f, s=%f\n”, x, log(1+x), s);
  }
  return 0;
}
2.7 Дано вещественное число x в заданном диапазоне. Вычислить сумму N членов ряда. Вычислить значение библиотечной функции cos(x). Полученные результаты вывести на экран для сравнения.
#include <stdio.h>
#include <math.h>

int main()
{
  int i,n,f,m;
  double x,s,z;
  for(;;)
  {
    printf(“Введите количество чисел ряда\n”);
    scanf(“%d”,&n);
    if(n<=0) break;
    printf(“Введите вещественное число\n”);
    scanf(“%lf “,&x);
    for(i=0, s=0, f=1, p=1, m=-1; i<=n; m*=-1, p*=2*x, f*=++i)
    {
	    s+=m*(p/2*f));
    }
    printf(“cos(%f)=%f, s=%f\n”, x, cos(x), s);
  }
  return 0;
}
2.8 Дано вещественное число x в заданном диапазоне. Вычислить сумму N членов ряда. Вычислить значение библиотечной функции asin(x). Полученные результаты вывести на экран для сравнения.
#include <stdio.h>
#include <math.h>

int main()
{
  int i,n;
  double x,s,z;
  for(;;)
  {
  printf(“Введите количество чисел ряда\n”);
  scanf(“%d”,&n);
  if(n<=0) break;
  printf(“Введите вещественное число\n”);
  scanf(“%lf “,&x);
  for(i=1; i<=n; i++)
    {
	    z=z*(2*i-1)/(2*i)*x*x*(2*i-1)/(2*i+1);
      s+=z;
    }
    printf(“asin(%f)=%f, s=%f\n”, x, asin(x), s);
  }
  return 0;
}
2.9 Дано вещественное число x в заданном диапазоне. Вычислить сумму N членов ряда. Вычислить значение библиотечной функции cosh(x). Полученные результаты вывести на экран для сравнения
#include <stdio.h>
#include <math.h>

int main()
  {
  int i,n;
  double x,s,z;
  for(;;)
  {
    printf(“Введите количество чисел ряда\n”);
    scanf(“%d”,&n);
    if(n<=0) break;
    printf(“Введите вещественное число\n”);
    scanf(“%lf “,&x);
    for(i=1,s=z=1; i<n; ++i)
    {
	    z*=x*x/(2*i*(2*i-1));
      s+=z;
    }
    printf(“cosh(%lf)=%lf, s=%lf\n”, x, cosh(x), s);
  }
  return 0;
}
