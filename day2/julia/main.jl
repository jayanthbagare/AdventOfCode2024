begin
  arr = []
  safe = 0
  unsafe = 0
  for line in eachline("input_data")
    l = parse.(Int32,split(line," "))
    println(l)
    # println(abs.(diff(l)))
    # println(length(findall(x->x>3,abs.(diff(l)))) )
    if (length(findall(x->x>3,abs.(diff(l)))) > 0)
      global unsafe += 1
      # println("Unsafe dur to diff")
    elseif(0 in abs.(diff(l)))
      global unsafe += 1
      # println("Unsafe as diff is zero")
    elseif(issorted(l,rev=true))
      global safe += 1
      # println("Safe as rev sort is true")
    elseif (issorted(l))
      global safe += 1
      # println("Safe as sort is true")
    else
      global unsafe += 1  
      # println("Unsafe as sort is not true")
    end
    # println("================================")
  end
  println("Safe:",safe)
  println("Unsafe:",unsafe)
end
