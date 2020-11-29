using DailyStockModel, Test

function tests()
    @testset "basic project test" begin
        @test 1 == 1
        @test DailyStockModel.down_to_func(4, 3) == DailyStockModel.MyStruct(12)
    end
end

tests()
