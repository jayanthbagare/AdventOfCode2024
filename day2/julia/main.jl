begin
  arr = []
  m = []
  safe = 0
  unsafe = 0
  msafe = 0
  munsafe = 0
  function safe_unsafe()
    for line in eachline("input_data")
      l = parse.(Int32,split(line," "))
      if (length(findall(x->x>3,abs.(diff(l)))) > 0)
        global unsafe += 1
      elseif(0 in abs.(diff(l)))
        idx = indexin(0,abs.(diff(l)))
        deleteat!(l,idx)
        global safe += 1
        push!(m,l)
      elseif(issorted(l,rev=true))
        global safe += 1
        push!(m,l)
      elseif (issorted(l))
        global safe += 1
        push!(m,l)
      else
        if(length(findall(x->x<0, diff(l))) <= 1)
          global safe += 1  
          push!(m,l)
        else
          global unsafe += 1
        end
      end
    end
  end
  safe_unsafe()
  println("Safe:",safe)
  println("Unsafe:",unsafe)
  # println("M is ", m)
  println("M size is ", size(m))
  for line in m
    l = line
    if (length(findall(x->x>3,abs.(diff(l)))) > 0)
      global munsafe += 1
    elseif(0 in abs.(diff(l)))
      idx = indexin(0,abs.(diff(l)))
      deleteat!(l,idx)
      global msafe += 1
      push!(m,l)
    elseif(issorted(l,rev=true))
      global msafe += 1
      push!(m,l)
    elseif (issorted(l))
      global msafe += 1
      push!(m,l)
    else
      if(length(findall(x->x<0, diff(l))) <= 1)
        global msafe += 1  
        push!(m,l)
      else
        global munsafe += 1
      end
    end
  end
  println("Safe:",msafe)
  println("Unsafe:",munsafe)
end
