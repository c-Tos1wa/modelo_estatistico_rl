#caso 1: Fatores de risco para COVID-19 grave
library(tidyverse)
library(broom)
library(survival)

#dados: pacientes com covid19
set.seed(2020)
n <- 500
data <- tibble(
  id = 1:n,
  age = round(pmin(pmax(rnorm(n, 50, 18), 18), 95)),
  gender = sample(c("F", "M"), n, replace = TRUE),
  diabetes = sample(c("N", "S"), n, replace = TRUE, prob = c(0.85, 0.15)),
  hypertension = sample(c("N", "S"), n, replace = TRUE, prob = c(0.7, 0.3)),
  obesity = sample(c("N", "S"), n, replace = TRUE, prob = c(0.75, 0.25))
) %>% 
  mutate(
    prob_high = plogis(
      -3 +
      0.04 * age +
      0.3 * (gender == "M") +
      0.8 * (diabetes == "S") +
      0.5 * (hypertension == "S") +
      0.6 * (obesity == "S")
      ),
    case = rbinom(n, 1, prob_high)
  )
head(data, 10)
View(data)

# análise descritiva
# quantidade e porcentagem de casos graves e não-graves
cases_severe <- table(data$case)
# resultado: não-grave = 302 / grave = 198
prop.table(cases_severe)*100
# resultado: não-grave = 60.4% / grave = 39.6%

# comparação de características entre casos graves e não-graves
comparison <- data %>% 
  group_by(case) %>% 
  summarise(
    total_pacientes = n(),
    idade_media = round(mean(age), 1),
    prop_masculino = round(mean(gender == "M") * 100, 1),
    prop_diabetes = round(mean(diabetes == "S") * 100, 1),
    prop_hipert = round(mean(hypertension == "S") * 100, 1),
    prop_obesidade = round(mean(obesity == "S") * 100, 1)
  )
View(comparison)

# modelo de regressão logistica'
covid <- glm(
  case ~ age + gender + diabetes + hypertension + obesity,
  data = data,
  family = binomial
)
summary(covid)

or <- tidy(
  covid,
  conf.int = TRUE,
  exponentiate = TRUE
)
print(or)
# resultado
# idade: chance de caso grave aumenta 0.06%, para cada ano a mais
# sexo masculino tem 39% mais chance de caso grave que feminino
# diabeticos tem 32% mais chance de ser caso grave
# hipertensos tem 57% mais chance
# obesos tem 137% mais chance de ser caso grave

# visualizar com Forest Plot
forest <- or %>% 
  filter(term != "(Intercept)") %>% 
  mutate(
    variable = case_when(
      term == "age" ~ "idade por ano",
      term == "genderM" ~ "sexo masculino",
      term == "diabetesS" ~ "diabetes",
      term == "hypertensionS" ~ "hipertensão",
      term == "obesityS" ~ "obesidade"
    )
  )
ggplot(forest, aes(estimate, reorder(variable, estimate))) +
  geom_vline(xintercept = 1,linetype = "dashed", color = "gray50") +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.2) +
  geom_point(size = 3, color = "darkred") +
  labs(
    title = "Fatores associados à covid grave",
    subtitle = "OR com IC 95%",
    x = "OR",
    y = ""
  ) +
  theme_minimal()
