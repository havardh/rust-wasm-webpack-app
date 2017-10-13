// Tells the rust complier to not generate the start function
#![no_main]

// Tells the rust compiler to use a naming scheme suitable for
// foreign function invocation, required by calling the function
// from Wasm
#[no_mangle]
pub fn add(a: i32, b: i32) -> i32 {
  return a + b;
}
