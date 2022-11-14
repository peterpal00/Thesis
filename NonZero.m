function nonzero = NonZero(matrixWithVector)
    nonzero = matrixWithVector(all(matrixWithVector,2), :);
end