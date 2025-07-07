# Estimating Mobile Phone Price Ranges using Machine Learning

This project presents a machine learning solution to classify mobile phones into distinct price categories—Low, Medium, High, and Very High—based on their hardware and feature specifications. It simulates a real-world scenario where accurate product positioning is crucial for market competitiveness and customer targeting.

The solution is implemented in R and leverages classification models including Support Vector Machines (SVM) and Random Forests, with a focus on model tuning and feature insights.

---

![Case Study Overview](Case%20Study%20-%20Estimating%20Price%20Range%20using%20Machine%20Learning.png)

---

## Dataset Overview

- Source: Provided as part of a case study
- Size: 2,000 observations × 21 features
- Target Variable: `price_range`
  - 0: Low
  - 1: Medium
  - 2: High
  - 3: Very High

### Feature Examples

| Feature         | Description                        |
|----------------|------------------------------------|
| `battery_power`| Battery capacity in mAh            |
| `ram`          | RAM in MB                          |
| `px_height`    | Screen resolution height           |
| `clock_speed`  | Processor speed (GHz)              |
| `dual_sim`     | Dual SIM support (0 or 1)          |
| ...            | (Full list in dataset description) |

---

## Tools & Techniques Used

- Language: R
- Core Libraries: `caret`, `e1071`, `randomForest`
- Techniques:
  - Data cleaning & feature engineering
  - Exploratory Data Analysis (EDA)
  - Model training & cross-validation
  - Hyperparameter tuning (SVM)
  - Feature importance evaluation

---

## Project Structure

```
📦 root/
├── train.csv                        # Training data (with labels)
├── test.csv                         # Test data (without labels)
├── Mobile_Case.R                    # Main R script for modeling
├── svm_tuned_model.rds             # Final trained SVM model (serialized)
└── Case Study Overview Image.png   # Visual overview of the case
```

---

## Model Performance & Outcomes

- Achieved high classification accuracy with tuned SVM and Random Forest models
- Identified RAM, battery power, and screen resolution as key pricing influencers
- Suitable for product tiering, marketing strategy, and price optimization scenarios

---

## How to Run

1. Clone the repository
2. Open `Mobile_Case.R` in RStudio or another R environment
3. Install required packages (`caret`, `e1071`, etc.)
4. Run the script to:
   - Load data
   - Train models
   - Evaluate results
   - Save or load tuned model (`svm_tuned_model.rds`)

---

## Use Cases

- Mobile phone product segmentation
- Price sensitivity analysis
- Market entry simulations for tech startups
- Feature-driven pricing insights for manufacturers

---

## Contact

For questions, suggestions, or collaboration inquiries, contact me at:

**rafaelahmedr@gmail.com**
