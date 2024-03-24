#include <iostream>
#include <Eigen/Dense>

int main() {
    // 创建一个3x3的矩阵
    Eigen::MatrixXd matrix(3, 3);
    
    // 初始化矩阵元素
    matrix << 1, 2, 3,
              4, 5, 6,
              7, 8, 9;

    // 输出矩阵
    std::cout << "Matrix:\n" << matrix << "\n\n";

    // 访问矩阵元素
    std::cout << "Element at (2,2): " << matrix(2, 2) << "\n\n";

    // 矩阵运算
    Eigen::VectorXd vector(3);
    vector << 1, 2, 3;

    Eigen::VectorXd result = matrix * vector;

    // 输出运算结果
    std::cout << "Result vector:\n" << result << "\n\n";

    return 0;
}

