contract PrimeChecker {
    function smallestfactor(uint256 n) returns (uint256) {
        for (uint256 i = 2; i * i <= n; i++) {
            if (n % i == 0) return i;
        }
        return n;
    }
}
