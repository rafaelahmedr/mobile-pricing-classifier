# Estimating Mobile Phone Price Ranges using Machine Learning

This project aims to build a machine learning model that classifies mobile phones into price categories based on technical specifications. It is based on a real-world business case study where pricing strategy is crucial for new entrants in the competitive mobile phone market.

---

## Background

Bob is a young entrepreneur who has recently launched his own mobile phone company. Determined to compete with established players like Apple, Samsung, and Xiaomi, he understands that accurate pricing is critical for market entry and consumer appeal.

To make informed pricing decisions, Bob collected a dataset containing detailed specifications of mobile phones from various manufacturers, along with the price range category of each phone. His goal is not to predict the exact price but to classify each phone into one of four price ranges—Low, Medium, High, or Very High—based on its features.

Lacking the technical skills, Bob has reached out for help to build a machine learning model that accomplishes this classification task.

---

## Objective

Build a model that predicts the price range (`price_range`) of a mobile phone based on its technical features. The model should also provide insight into which features most influence pricing, helping Bob strategically position his products in the market.

---

## Dataset Overview

- **Observations**: 2,000 rows
- **Features**: 20 independent variables + 1 target variable
- **Target variable**: `price_range` (0 = Low, 1 = Medium, 2 = High, 3 = Very High)

---

## Variable Descriptions

| Variable       | Description                               | Type        |
|----------------|-------------------------------------------|-------------|
| battery_power  | Battery capacity in mAh                   | Integer     |
| blue           | Bluetooth support (1: Yes, 0: No)         | Binary      |
| clock_speed    | Processor speed in GHz                    | Numeric     |
| dual_sim       | Dual SIM support (1: Yes, 0: No)          | Binary      |
| fc             | Front camera megapixels                   | Integer     |
| four_g         | 4G support (1: Yes, 0: No)                 | Binary      |
| int_memory     | Internal memory in GB                     | Integer     |
| m_dep          | Mobile depth in cm                        | Numeric     |
| mobile_wt      | Weight of mobile in grams                 | Integer     |
| n_cores        | Number of processor cores                 | Integer     |
| pc             | Primary camera megapixels                 | Integer     |
| px_height      | Pixel resolution height                   | Integer     |
| px_width       | Pixel resolution width                    | Integer     |
| ram            | RAM in MB                                 | Integer     |
| sc_h           | Screen height in cm                       | Integer     |
| sc_w           | Screen width in cm                        | Integer     |
| talk_time      | Battery backup in hours                   | Integer     |
| three_g        | 3G support (1: Yes, 0: No)                 | Binary      |
| touch_screen   | Touch screen (1: Yes, 0: No)              | Binary      |
| wifi           | WiFi support (1: Yes, 0: No)              | Binary      |
| price_range    | Target: 0=Low, 1=Medium, 2=High, 3=Very High | Categorical |

---

## Tools & Techniques Used

- Language: R
- Libraries: `caret`, `e1071`, `randomForest`
- Techniques:
  - Data cleaning and transformation
  - Feature engineering and scaling
  - Classification using Random Forest and SVM
  - Hyperparameter tuning
  - Model evaluation and feature importance analysis

---

## Project Structure

```
📦 root/
├── train.csv                        # Training dataset with labels
├── test.csv                         # Testing dataset
├── Mobile_Case.R                    # R script for full ML pipeline
├── svm_tuned_model.rds             # Saved final SVM model
├── Case Study - Estimating Price Range using Machine Learning.png
└── README.md                        # Project documentation
```

---

## Results

- The best performing model was an SVM with tuned hyperparameters
- Achieved high classification accuracy on validation data
- Key influential features included `ram`, `battery_power`, `px_height`, and `px_width`

---

## How to Use

1. Clone this repository.
2. Open `Mobile_Case.R` in RStudio.
3. Install required packages (`caret`, `e1071`, `randomForest`, etc.).
4. Run the script to:
   - Load and preprocess data
   - Train and evaluate models
   - Save/load final model

---

## Contact

For questions, feedback, or collaboration:

**rafaelahmedr@gmail.com**
