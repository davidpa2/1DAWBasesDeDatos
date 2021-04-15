1º select * from empleados;
2º select * from dept;
3º select * from emp where job = 'clerk';
4º select * from emp where job = 'clerk' order by ename;
5º select * from emp where job = 'clerk' order by ename desc;
6º select ename, sal from emp;
7º select dname from dept;
8º select dname from dept order by dname;
9º select dname from dept order by loc;
10º select dname from dept order by dname desc;
11º select ename, job from emp order by sal;
12º select ename, job from emp order by job, sal;
13º select ename, job from emp order by job desc, sal;
14º select sal, comm from emp where deptno = 30;
15º select sal, comm from emp where deptno = 30 order by comm;
16º select comm from emp 
17º select distinct comm, dname from emp;
18º select distinct 
19º
20º select ename, sal+1000 from emp where deptno=30;
21º select ename, sal, sal+1000 as total, from emp where deptno=30;
22º select ename, sal, comm from emp where ifnull (comm, 0) >= sal/2;
23º select ename, sal, comm from emp where ifnull (comm, 0) <= sal*0,25;
24º select concat (ename, ' ', job) as "nombre y puesto" from emp;
25º select sal, comm from emp where empno >7500;
26º select ename, job from emp where ename >= 'J' order by ename;
27º select sal, comm, sal+comm "salario total"  from emp where comm is not null order by empno;
28º select sal, comm, ifnull(comm,0)+salario "salario total"  from emp where comm is null order by empno;
29º select ename from emp where sal > 1000 && mgr = 7698;
30º select ename from emp where not (sal > 1000 && mgr = 7698);
31º select ename, (ifnull(comm,0) * 100)/sal porcentaje from emp order by ename;
32º select * from emp where deptno = 10 && ename notlike '%LA%';
33º select * from emp where mgr = null;
34º select dname from dept where dname != 'sales' and dname != 'research' order by loc;
35º select ename, deptno from emp where job = 'clerk'and deptno != 10 and sal > 800 order by hiredate;
36º select ename, sal / comm cociente where comm > 0 order by ename;
37º select * from emp where ename like '_____';
38º select * from emp where ename like '_____%';
39º select * from emp where (ename like 'A%' and sal > 1000) || (comm > 0 and deptno = 30);
40º select ename, sal + ifnull(comm,0) as salTotal from emp order by salTotal, sal;

60º select ename from emp where sal >= (select avg(sal) from emp);

61º select ename, sal, emp.deptno from emp join (select deptno, max(sal) maximo from emp group by deptno) T1 where emp.sal = T1.maximo and T1.deptno = emp.deptno;

62º select count(distinct ename), count(distinct job), count(distinct sal), sum(sal) from emp where deptno=30;

63º select count(comm) from emp;

64º select count(deptno) empleados from emp where deptno = 20;

65º select deptno, count(*) from emp group by deptno having count(*) >= 3;

66º select * from emp where job in (select distinct job from emp join dept using(deptno) where dname='sales') and deptno = 10;

67º select empno, ename from emp join (select distinct mgr from emp where mgr is not null) T1 where emp.empno = T1.mgr;
---------------------------------------
68º select * from emp e join dept d using (deptno) where d.loc = 'Chicago';

69º select distinct job, sum(ename) from emp group by job;

70º select sum(sal) from emp group by job;

71º select deptno from emp;

72º select ename from emp where mgr = null;

73º select deptno, count(deptno), avg(sal) from emp group by deptno;

74º select ename from emp where deptno = 30 order by comm;

75º select ename from emp e join dept d using (deptno) where d.loc = 'Dalas' and d.loc = 'New York';

76º select empno, ename from emp 

77º select sal, deptno, max(sal) from emp group by deptno;

78º select sum(sal) suma, max(suma) from emp group by deptno;

79º select sum(sal) suma from emp group by deptno order by suma limit 2;

80º select empno, sum(sal) suma, d.dname from emp e join deptno d using (deptno) where sum(ename) >= 2 group by deptno;