## `ps_complete.Rds` (input) is a cleaned up phyloseq-object based on code included in the
## MUIS5_NP-project (`load_NP.Rmd`). Among others, the data was curated, `decontam`-inated and
## undoubled.

## Here, we make a selection of samples, so these can be used to demonstrate functions contained
## in this package.

library(here)
library(tidyverse)
library(phyloseq)

ps_complete <- read_rds(here("data-raw", "ps_complete.Rds"))

ps_NP<- ps_complete %>%
  subset_samples(., niche == "NP" & str_ends(V_name, "w1|m1|y1")) %>% # only select these time points
  prune_taxa(!taxa_sums(.) == 0, .) # remove taxa not occuring

sample_data(ps_NP) <- ps_NP %>%
  sample_data() %>%
  data.frame() %>%
  tibble::rownames_to_column("sample_id") %>%
  select(sample_id, seq_id, visit_name = "V_name", age, birth_mode, bf_group_3m_yn = bv_group_3m_yn) %>%
  tibble::column_to_rownames("sample_id") %>%
  sample_data()

#write_rds(ps_NP, path = here("data-raw", "ps_NP.rds"))

usethis::use_data(ps_NP, overwrite = TRUE)

