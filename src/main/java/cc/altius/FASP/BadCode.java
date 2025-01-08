package cc.altius.FASP;

public class BadCode {
    private int a, b, c, d, e, f, g, h; // Too many fields
    
    // Method with too many parameters
    public void doSomething(int param1, int param2, int param3, int param4, int param5) {
        // Nested control flow beyond threshold
        if (param1 > 0) {
            if (param2 > 0) {
                if (param3 > 0) {
                    if (param4 > 0) {
                        if (param5 > 0) {
                            System.out.println("Too deep!");
                        }
                    }
                }
            }
        }
    }

    // Complex method with high cyclomatic complexity
    public int calculateSomething(int x) {
        int result = 0;
        
        // Multiple return statements
        if (x < 0) return -1;
        if (x == 0) return 0;
        if (x > 100) return 100;
        if (x % 2 == 0) return x * 2;
        if (x % 3 == 0) return x * 3;
        
        // Complex logic with many branches
        for (int i = 0; i < x; i++) {
            if (i % 2 == 0) {
                result += i;
            } else if (i % 3 == 0) {
                result += i * 2;
            } else if (i % 5 == 0) {
                result += i * 3;
            } else {
                result += 1;
            }
        }
        
        return result;
    }

    // Duplicate code block 1
    public void duplicateMethod1() {
        int sum = 0;
        for (int i = 0; i < 100; i++) {
            sum += i;
            System.out.println("Processing: " + i);
            if (i % 2 == 0) {
                sum += 5;
            }
        }
    }

    // Duplicate code block 2
    public void duplicateMethod2() {
        int sum = 0;
        for (int i = 0; i < 100; i++) {
            sum += i;
            System.out.println("Processing: " + i);
            if (i % 2 == 0) {
                sum += 5;
            }
        }
    }
} 