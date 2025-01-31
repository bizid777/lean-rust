

fn main() {
  println!("Hello, world! {}",fib(10));
  println!("{}",sumupton(100));
}

pub fn fib (n:u32)-> u32{
  if n == 0{
      1
  }else if n == 1{
      1
  }else{
      fib(n-1) + fib(n-2)
  }
}

 
pub fn sumupton (n:u32)-> u32{
    if n == 0{
        0
    }else{
        n + sumupton(n-1)
    }
}

