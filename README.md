# jediAnalysis

[![R-CMD-check](https://github.com/yuma-tietiedaxiang/jediAnalysis/actions/workflows/r.yml/badge.svg)](https://github.com/yuma-tietiedaxiang/jediAnalysis/actions/workflows/r.yml)

An R package for mixed-effects model analysis, built to explore whether psychological factors (anger, emotional bonds) predict outcome levels in a hierarchically structured dataset — 95 dojos, each containing multiple Jedi apprentices.

> Full analysis vignette: https://rpubs.com/Yoma_dev/1427191  
> Source code: https://github.com/yuma-tietiedaxiang/jediAnalysis

---

## Why this package exists

When data has a clustered structure (students within schools, plots within farms, apprentices within dojos), standard linear regression is not appropriate — it ignores the within-group correlation. This package wraps `lme4` to make mixed-effects model fitting, assessment, and comparison accessible through a clean, opinionated API.

The three exported functions each address a distinct step in the mixed-model workflow:

| Function                         | What it does                                                 | Why it matters                                               |
| -------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `fixed_effects(model)`           | Extracts fixed effect estimates with a significance flag (t > 2 rule) | `lme4::lmer()` does not return p-values by default; this makes results interpretable without adding a heavy dependency like `lmerTest` |
| `compute_icc(model)`             | Returns ICC and design effect from a fitted model            | ICC quantifies how much variance is explained by group membership — essential for justifying a mixed-model approach and understanding cluster structure |
| `compare_models(model1, model2)` | Compares two models on AIC and BIC                           | Enables structured model selection when deciding whether to include additional predictors |

---

## Installation

```r
# install.packages("devtools")
devtools::install_github("yuma-tietiedaxiang/jediAnalysis")
```

## Quick start

```r
library(jediAnalysis)
library(lme4)

data("jedi")

# Fit a baseline model: does anger predict darkness, accounting for dojo?
m1 <- lmer(darkness ~ anger + (1 | dojo_id), data = jedi)

# Is the grouping structure meaningful?
compute_icc(m1)

# Does adding emotional_bonds improve the model?
m2 <- lmer(darkness ~ anger + emotional_bonds + (1 | dojo_id), data = jedi)
compare_models(m1, m2)

# Inspect fixed effects with significance flags
fixed_effects(m2)
```

---

## Package structure

This is a standard R package built with `devtools` and `roxygen2`:

```
jediAnalysis/
├── R/                   # Function source files
├── man/                 # Auto-generated documentation (roxygen2)
├── vignettes/           # Full analysis walkthrough (published to RPubs)
├── data/                # jedi dataset
├── tests/               # testthat test suite
├── DESCRIPTION          # Package metadata and dependencies
└── NAMESPACE            # Exported functions
```

Documentation is written inline with roxygen2 and rendered to man pages. The vignette walks through the full analytical workflow — from exploratory data analysis through model selection and interpretation — and is published at https://rpubs.com/Yoma_dev/1427191.

---

## Skills demonstrated

This project was built as a portfolio piece for the **ANU Research Software Engineer** position (RSFAS / AAGI). It directly addresses several of the role's core requirements:

- **R package development**: complete package lifecycle from `usethis::create_package()` through roxygen2 documentation, vignette authoring, and GitHub hosting
- **Statistical modelling**: applied mixed-effects modelling using `lme4`, including ICC computation and AIC/BIC-based model comparison
- **Experimental design awareness**: ICC and design effect calculations reflect understanding of how cluster structure affects inference — directly relevant to field trial data common in the Australian grains industry
- **User-focused API design**: functions abstract away lme4's lower-level output into tidy data frames, reducing friction for researchers who need results, not boilerplate
- **Technical documentation**: roxygen2 man pages with usage examples, plus a narrative vignette suitable for both technical and non-technical audiences

---

## Data

The `jedi` dataset is a synthetic dataset (95 dojos, ~10 apprentices each) designed to illustrate two-level hierarchical data. Variables: `darkness` (outcome), `anger`, `emotional_bonds` (predictors), `dojo_id` (grouping factor).

---

## License

MIT © Yoma Ma
