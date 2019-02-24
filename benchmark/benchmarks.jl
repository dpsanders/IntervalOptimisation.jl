include("examples.jl")
using .OneDimExamples, .TwoDimExamples

using BenchmarkTools
using IntervalArithmetic
using IntervalOptimisation

const SUITE = BenchmarkGroup()


S = SUITE["One dimentional function"] = BenchmarkGroup()

for func in (OneDimExamples.func1, OneDimExamples.func2, OneDimExamples.func3)
    s = S[func.title] = BenchmarkGroup()
	for structure in (HeapedVector, SortedVector)
		s[string(Structure)] = @benchmarkable minimise($(func.func), $(func.region), $structure)
    end
end


S = SUITE["Two dimensional function"] = BenchmarkGroup()

for func in (TwoDimExamples.Rosenbrock)
    s = S[func.title] = BenchmarkGroup()
	for structure in (HeapedVector, SortedVector)
		s[string(Structure)] = @benchmarkable minimise($(func.func), $(func.region), $structure )
    end
end
