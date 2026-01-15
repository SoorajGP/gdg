# Transaction Fraud Detection under Class Imbalance

This project addresses the problem of detecting fraudulent credit card transactions in a highly imbalanced real-world dataset.  
The dataset contains transactions made by European cardholders, where fraudulent cases are extremely rare.

---

## Dataset

- **Source:** Kaggle – Credit Card Fraud Detection Dataset  
- **Total transactions:** 284,807  
- **Fraud cases:** ~0.17%  
- **Features:** PCA-transformed numerical features, along with `Amount` and `Time`

The dataset is downloaded locally for execution and is excluded from version control using `.gitignore`.

---

## Key Challenges

- Extreme class imbalance makes accuracy misleading
- False negatives (missed fraud) have high financial cost
- False positives negatively impact customer experience
- Models must be evaluated using appropriate metrics

---

## Exploratory Data Analysis

- Quantified severe class imbalance
- Compared feature distributions for fraudulent vs legitimate transactions
- Identified informative features such as transaction amount and selected PCA components

---

## Models Implemented

### 1. Logistic Regression (Baseline)
- Used class-weighted loss to handle imbalance
- Achieved very high recall for fraud detection
- Lower precision due to increased false positives

### 2. Random Forest + SMOTE
- Applied SMOTE only on training data to address imbalance
- Captured non-linear patterns
- Achieved high recall **and** significantly improved precision

---

## Evaluation Metrics

Due to class imbalance, the following metrics were used:
- Precision
- Recall
- F1-score
- ROC-AUC

Accuracy was not relied upon as a primary metric.

---

## Key Results (Summary)

| Model               | Recall (Fraud) | Precision (Fraud) | ROC-AUC |
|--------------------|---------------|------------------|---------|
| Logistic Regression | ~0.97          | ~0.16            | ~0.98   |
| Random Forest       | ~0.97          | ~0.90            | ~0.98   |

Random Forest significantly reduced false positives while maintaining strong fraud detection performance.

---

## Additional Analysis (Brownie Points)

- Threshold optimization to balance recall and precision
- Error pattern analysis and business impact discussion
- Feature importance analysis using Random Forest
- Ethical considerations regarding false positives and user fairness

---

## Production Considerations

- Threshold tuning based on business risk
- Continuous monitoring for concept drift
- Periodic retraining
- Balancing security and customer experience

---

## Author

**Sooraj G P**  
Fresher, VIT Vellore
