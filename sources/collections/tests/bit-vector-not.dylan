Module:       collections-test-suite
Synopsis:     Test bit-vector-not function
Author:       Keith Dennison
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define function mixed-bits(sized :: <integer>, #key seed = 0) => (members :: <collection>, non-members :: <collection>)
  let m = make(<list>);
  let n = make(<list>);
  for (i from 0 below sized)
    let threes = zero?(modulo(i + seed, 3));
    let fives = zero?(modulo(i + seed, 5));
    if ((threes & ~ fives) | (~ threes & fives))
      m := add!(m, i);
    else
      n := add!(n, i);
    end if;
  end for;
  values(m, n)
end function;

/// Test 'bit-vector-not' on vectors of the given size
define function bit-vector-not-sized (sized :: <integer>) => ()
  let vector1 :: <bit-vector> = make(<bit-vector>, size: sized);
  let vector2 :: <bit-vector> = make(<bit-vector>, size: sized, fill: 1);
  let vector3 :: <bit-vector> = make(<bit-vector>, size: sized);
  let name = if (zero?(sized)) "Empty vector" else format-to-string("Vector of size %d", sized) end;

  let (vector3-elements, not-vector3-elements) = mixed-bits(sized);
  do(method(bit) vector3[bit] := 1 end, vector3-elements);

  // bit-vector-not of an all-zero vector
  //
  let (result, result-pad) = bit-vector-not(vector1);
  bit-vector-checks(result, result-pad,
    format-to-string("bit-vector-not of an all-zero %s with default pad", name),
    sized, #"all-ones", 1);

  let (result, result-pad) = bit-vector-not(vector1, pad: 1);
  bit-vector-checks(result, result-pad,
    "bit-vector-not of an all-zero vector with pad = 1",
    sized, #"all-ones", 0);

  // bit-vector-not of an all-one vector
  //
  let (result, result-pad) = bit-vector-not(vector2, pad: 0);
  bit-vector-checks(result, result-pad,
    "bit-vector-not of an all-one vector with pad = 0",
    sized, #"all-zeros", 1);

  let (result, result-pad) = bit-vector-not(vector2, pad: 1);
  bit-vector-checks(result, result-pad,
    "bit-vector-not of an all-one vector with pad = 1",
    sized, #"all-zeros", 0);

  // bit-vector-not of a vector
  //
  let (result, result-pad) = bit-vector-not(vector3);
  bit-vector-checks(result, result-pad,
    format-to-string("bit-vector-not of a %s with default pad", name),
    sized, not-vector3-elements, 1);

  let (result, result-pad) = bit-vector-not(vector3, pad: 1);
  bit-vector-checks(result, result-pad,
    "bit-vector-not of a vector with pad = 1",
    sized, not-vector3-elements, 0);
end function;

/// Test 'bit-vector-not' on vectors of the given size
define function bit-vector-not!-sized (sized :: <integer>) => ()
  let vector1 :: <bit-vector> = make(<bit-vector>, size: sized);
  let vector2 :: <bit-vector> = make(<bit-vector>, size: sized);
  let vector3 :: <bit-vector> = make(<bit-vector>, size: sized);
  let name = if (zero?(sized)) "Empty vector" else format-to-string("Vector of size %d", sized) end;
  
  let (vector3-elements, not-vector3-elements) = mixed-bits(sized);
  do(method(bit) vector3[bit] := 1 end, vector3-elements);

  // bit-vector-not! of an all-zero vector
  //
  let (result, result-pad) = bit-vector-not!(vector1);
  check-equal("With default pad, bit-vector-not!(vector1) == vector1",
    result, vector1);
  bit-vector-checks(result, result-pad,
    format-to-string("bit-vector-not! of an all-zero %s with default pad", name),
    sized, #"all-ones", 1);

  let (result, result-pad) = bit-vector-not!(vector2, pad: 1);
  check-equal("With pad = 1, bit-vector-not!(vector2) == vector2",
    result, vector2);
  bit-vector-checks(result, result-pad,
    format-to-string("bit-vector-not! of an all-zero %s with pad = 1", name),
    sized, #"all-ones", 0);

  // bit-vector-not of an all-one vector
  //
  let (result, result-pad) = bit-vector-not!(vector1, pad: 0);
  check-equal("With pad = 0, bit-vector-not!(vector1) == vector1",
    result, vector1);
  bit-vector-checks(result, result-pad,
    format-to-string("bit-vector-not! of an all-one vector with pad = 0", name),
    sized, #"all-zeros", 1);

  let (result, result-pad) = bit-vector-not!(vector2, pad: 1);
  check-equal("With pad = 1, bit-vector-not!(vector2) == vector2",
    result, vector2);
  bit-vector-checks(result, result-pad,
    format-to-string("bit-vector-not! of an all-one %s with pad = 1", name),
    sized, #"all-zeros", 0);

  // bit-vector-not of a vector
  //
  let (result, result-pad) = bit-vector-not!(vector3);
  check-equal("With default pad, bit-vector-not!(vector3) == vector3",
    result, vector3);
  bit-vector-checks(result, result-pad,
    format-to-string("bit-vector-not! of a %s with default pad", name),
    sized, not-vector3-elements, 1);

  let (result, result-pad) = bit-vector-not!(vector3, pad: 1);
  check-equal("With pad = 1, bit-vector-not!(vector3) == vector3",
    result, vector3);
  bit-vector-checks(result, result-pad,
    format-to-string("bit-vector-not! of a %s with pad = 1", name),
    sized, vector3-elements, 0);
end function;

define test bit-vector-not-empty-vector (description: "Test bit-vector-not on empty vectors")
  bit-vector-not-sized(0);
end test;

define test bit-vector-not!-empty-vector (description: "Test bit-vector-not! on empty vectors")
  bit-vector-not!-sized(0);
end test;

define test bit-vector-not-tiny-vector (description: "Test bit-vector-not on tiny vectors")
  bit-vector-not-sized($tiny-size);
end test;

define test bit-vector-not!-tiny-vector (description: "Test bit-vector-not! on tiny vectors")
  bit-vector-not!-sized($tiny-size);
end test;

define test bit-vector-not-huge-vector (description: "Test bit-vector-not on huge vectors")
  bit-vector-not-sized($huge-size);
end test;

define test bit-vector-not!-huge-vector (description: "Test bit-vector-not! on huge vectors")
  bit-vector-not!-sized($huge-size);
end test;

define test bit-vector-not-multiple-word-sized-vector (description: "Test bit-vector-not on multiple word size vectors")
  bit-vector-not-sized($multiple-word-size);
end test;

define test bit-vector-not!-multiple-word-sized-vector (description: "Test bit-vector-not! on multiple word size vectors")
  bit-vector-not!-sized($multiple-word-size);
end test;


define suite bit-vector-not-suite ()
  test bit-vector-not-empty-vector;
  test bit-vector-not!-empty-vector;
  test bit-vector-not-tiny-vector;
  test bit-vector-not!-tiny-vector;
  test bit-vector-not-huge-vector;
  test bit-vector-not!-huge-vector;
  test bit-vector-not-multiple-word-sized-vector;
  test bit-vector-not!-multiple-word-sized-vector;
end suite;
