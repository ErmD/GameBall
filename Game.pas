uses GraphWPF, WPFObjects, Timers;

var speed1 := 2; //Ball speed
var speed2 := 3; //Enemy speed

var timeCount:= new TextWPF(370,10,20,'10', colors.Blue);

var ballRadius := 30;
var (x,y) := (ballRadius,ballRadius);
var Ball := new CircleWPF(ballRadius,ballRadius,ballRadius,gcolor.Fromrgb(255,0,0));
var (ml,mr,mt,mb) :=(false,false,false,false);

var ballRadius1 := 20;
var (x1,y1) := (810-ballRadius1,610-ballRadius1);
var Enemy := new CircleWPF(810-ballRadius1,610-ballRadius1,ballRadius1,gcolor.Fromrgb(0,0,255));
var (el,er,et,eb) :=(false,false,false,false);

//Настройки
procedure setup();
  begin
    Window.SetSize(800,600);
    Window.Caption := 'Игра из палок';
    Window.IsFixedSize := true;
    Window.CenterOnScreen();
  end;

//Клавиши
procedure keyDown(k: Key);
begin
  case k of
    Key.W: mt :=true;
    Key.S: mb :=true;
    Key.A: ml :=true;
    Key.D: mr :=true;
    
    Key.Up: et :=true;
    Key.Down: eb :=true;
    Key.Left: el :=true;
    Key.Right: er :=true;
  end;
end;

procedure keyUp(k: Key);
begin
  case k of
    Key.W: mt :=false;
    Key.S: mb :=false;
    Key.A: ml :=false;
    Key.D: mr :=false;
    
    Key.Up: et :=false;
    Key.Down: eb :=false;
    Key.Left: el :=false;
    Key.Right: er :=false;
  end;
end;

procedure TimerBall;
begin  
  var Going:= new TextWPF(343,270,40,'Догнал!', colors.blue);
  Going.BackgroundColor := colors.Black;
  Going.Color := colors.White;
  Going.FontSize:= 40;
  sleep(1000);
  Going.Destroy;
end;

procedure timeTimer;
begin
  timeCount.Text := (strToInt(timeCount.Text) - 1).ToString;
end;

//Основа
begin
  
  setup();

  OnKeyDown := KeyDown;
  OnKeyUp := KeyUp;
  
  Var t := new Timer(10,TimerBall);
  var time := New Timer (1000,timeTimer);
  time.Start;
  
  var gameState := true;
  while gameState do
    begin
      if ObjectsIntersect(Ball,Enemy) then 
        begin
          
          t.Start;
          Sleep(3000);
          t.Stop;

          Ball.Left := 0;
          Ball.Top := 0;
          (x,y) := (ballRadius,ballRadius);
          
          Enemy.Left := 810-2*ballRadius1;
          Enemy.Top := 610-2*ballRadius1;
          (x1,y1) := (810-ballRadius1,610-ballRadius1);
          
        end;
      
      if ((ml)and(x>ballRadius)) then 
        begin
          Ball.Left -= Speed1;
          x-=speed1;
        end;
      if ((mr)and(x<810-ballRadius)) then 
        begin
          Ball.Left += speed1;
          x+=speed1;
        end;
      if ((mt)and(y>ballRadius)) then
        begin
          Ball.Top -= speed1;
          y-=speed1;
        end;
      if ((mb)and(y<610-ballRadius)) then 
        begin
          Ball.Top += speed1;
          y+=speed1;
        end;
          
        {----------------------------------------}
        
      if ((el)and(x1>ballRadius1)) then 
        begin
          Enemy.Left -= speed2;
          x1-=speed2;
        end;
      if ((er)and(x1<810-ballRadius1)) then 
        begin
          Enemy.Left += speed2;
          x1+=speed2;
        end;
      if ((et)and(y1>ballRadius1)) then
        begin
          Enemy.Top -= speed2;
          y1-=speed2;
        end;
      if ((eb)and(y1<610-ballRadius1)) then 
        begin
          Enemy.Top += speed2;
          y1+=speed2;
        end;
    sleep(5);
    end;
  
end.