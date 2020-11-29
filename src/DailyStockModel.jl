module DailyStockModel


# style guide for julia, camel case for modules, structs and types
# snake case for functions.

struct MyStruct
    x::Number
end


function down_to_func(x::Number, y::Number)::MyStruct
    retval = MyStruct(x * y);
    return(retval)
end

println("Hi Everybody!")
myvar = down_to_func(5, 20)
println(myvar.x)

end # module
