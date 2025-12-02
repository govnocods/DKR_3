program Lab3;

function f(x: real): real;
begin
  f := 2*x*x*x + (-1)*x*x + (1)*x + (16);
end;

function CalculateIntegral(a, b: real; n: integer): real;
var
  h, x, sum: real;
  i: integer;
begin
  if n <= 0 then
  begin
    CalculateIntegral := 0;
    exit;
  end;
  
  h := (b - a) / n;
  sum := 0;
  
  for i := 0 to n - 1 do
  begin
    x := a + (i + 0.5) * h;
    if f(x) > 0 then
      sum := sum + f(x);
  end;
  
  CalculateIntegral := sum * h;
end;

function EstimateError(a, b: real; n: integer): real;
var
  I_n, I_2n: real;
begin
  I_n := CalculateIntegral(a, b, n);
  I_2n := CalculateIntegral(a, b, 2 * n);
  EstimateError := abs(I_2n - I_n);
end;

procedure CalculateArea;
var
  a, b, result, error: real;
  n: integer;
begin
  writeln('=== Вычисление площади фигуры ===');
  write('Введите нижний предел интегрирования: ');
  readln(a);
  write('Введите верхний предел интегрирования: ');
  readln(b);
  
  if a >= b then
  begin
    writeln('Ошибка: нижний предел должен быть меньше верхнего!');
    exit;
  end;
  
  write('Введите количество разбиений (рекомендуется >= 1000): ');
  readln(n);
  
  if n <= 0 then
  begin
    writeln('Ошибка: количество разбиений должно быть положительным!');
    exit;
  end;
  
  result := CalculateIntegral(a, b, n);
  error := EstimateError(a, b, n);
  
  writeln;
  writeln('Результат:');
  writeln('Площадь фигуры: ', result:0:6);
  writeln('Оценка погрешности: ', error:0:6);
  writeln('Относительная погрешность: ', (error / result * 100):0:4, '%');
  writeln;
end;

procedure ShowInfo;
begin
  writeln('=== Информация о программе ===');
  writeln('Программа вычисляет площадь фигуры, ограниченной кривой');
  writeln('f(x) = 2*x^3 - x^2 + x + 16');
  writeln('и осью OX (в положительной части по оси OY)');
  writeln('Метод: средних прямоугольников');
  writeln;
end;

procedure ShowMenu;
begin
  writeln('=== МЕНЮ ===');
  writeln('1. Вычислить площадь фигуры');
  writeln('2. Показать информацию о программе');
  writeln('0. Выход');
  write('Выберите пункт меню: ');
end;


var
  choice: integer;
begin  
  repeat
    ShowMenu;
    readln(choice);
    writeln;
    
    case choice of
      1: CalculateArea;
      2: ShowInfo;
      0: writeln('Выход из программы...');
      else
        writeln('Неверный выбор! Попробуйте снова.');
    end;
    
    if choice <> 0 then
    begin
      writeln('Нажмите Enter для продолжения...');
      readln;
      writeln;
    end;
  until choice = 0;
end.

