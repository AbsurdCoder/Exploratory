{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "34c61303",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:47.925639Z",
     "iopub.status.busy": "2023-03-29T18:28:47.923721Z",
     "iopub.status.idle": "2023-03-29T18:28:59.227487Z",
     "shell.execute_reply": "2023-03-29T18:28:59.225446Z"
    },
    "papermill": {
     "duration": 11.317218,
     "end_time": "2023-03-29T18:28:59.231469",
     "exception": false,
     "start_time": "2023-03-29T18:28:47.914251",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.2 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.6      \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.8      \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.10\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.1      \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.1 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.2      \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.2 \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'fitbit'"
      ],
      "text/latex": [
       "'fitbit'"
      ],
      "text/markdown": [
       "'fitbit'"
      ],
      "text/plain": [
       "[1] \"fitbit\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "library(readr)\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session\n",
    "\n",
    "daily_activity <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv\")\n",
    "daily_calories <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/dailyCalories_merged.csv\")\n",
    "daily_intensities <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/dailyIntensities_merged.csv\")\n",
    "daily_steps <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/dailySteps_merged.csv\")\n",
    "heartrate_per_second <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/heartrate_seconds_merged.csv\")\n",
    "METs_per_minute <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/minuteMETsNarrow_merged.csv\")\n",
    "daily_sleep <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv\")\n",
    "weight_log <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/weightLogInfo_merged.csv\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "63ca45f0",
   "metadata": {
    "papermill": {
     "duration": 0.004739,
     "end_time": "2023-03-29T18:28:59.241270",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.236531",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "We will check the details daily dataset that's being provided to us."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "28816b47",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.281219Z",
     "iopub.status.busy": "2023-03-29T18:28:59.251985Z",
     "iopub.status.idle": "2023-03-29T18:28:59.335345Z",
     "shell.execute_reply": "2023-03-29T18:28:59.333666Z"
    },
    "papermill": {
     "duration": 0.09172,
     "end_time": "2023-03-29T18:28:59.337560",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.245840",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Daily Activity\"\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Id'</li><li>'ActivityDate'</li><li>'TotalSteps'</li><li>'TotalDistance'</li><li>'TrackerDistance'</li><li>'LoggedActivitiesDistance'</li><li>'VeryActiveDistance'</li><li>'ModeratelyActiveDistance'</li><li>'LightActiveDistance'</li><li>'SedentaryActiveDistance'</li><li>'VeryActiveMinutes'</li><li>'FairlyActiveMinutes'</li><li>'LightlyActiveMinutes'</li><li>'SedentaryMinutes'</li><li>'Calories'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Id'\n",
       "\\item 'ActivityDate'\n",
       "\\item 'TotalSteps'\n",
       "\\item 'TotalDistance'\n",
       "\\item 'TrackerDistance'\n",
       "\\item 'LoggedActivitiesDistance'\n",
       "\\item 'VeryActiveDistance'\n",
       "\\item 'ModeratelyActiveDistance'\n",
       "\\item 'LightActiveDistance'\n",
       "\\item 'SedentaryActiveDistance'\n",
       "\\item 'VeryActiveMinutes'\n",
       "\\item 'FairlyActiveMinutes'\n",
       "\\item 'LightlyActiveMinutes'\n",
       "\\item 'SedentaryMinutes'\n",
       "\\item 'Calories'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Id'\n",
       "2. 'ActivityDate'\n",
       "3. 'TotalSteps'\n",
       "4. 'TotalDistance'\n",
       "5. 'TrackerDistance'\n",
       "6. 'LoggedActivitiesDistance'\n",
       "7. 'VeryActiveDistance'\n",
       "8. 'ModeratelyActiveDistance'\n",
       "9. 'LightActiveDistance'\n",
       "10. 'SedentaryActiveDistance'\n",
       "11. 'VeryActiveMinutes'\n",
       "12. 'FairlyActiveMinutes'\n",
       "13. 'LightlyActiveMinutes'\n",
       "14. 'SedentaryMinutes'\n",
       "15. 'Calories'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"Id\"                       \"ActivityDate\"            \n",
       " [3] \"TotalSteps\"               \"TotalDistance\"           \n",
       " [5] \"TrackerDistance\"          \"LoggedActivitiesDistance\"\n",
       " [7] \"VeryActiveDistance\"       \"ModeratelyActiveDistance\"\n",
       " [9] \"LightActiveDistance\"      \"SedentaryActiveDistance\" \n",
       "[11] \"VeryActiveMinutes\"        \"FairlyActiveMinutes\"     \n",
       "[13] \"LightlyActiveMinutes\"     \"SedentaryMinutes\"        \n",
       "[15] \"Calories\"                "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 940\n",
      "Columns: 15\n",
      "$ Id                       \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1503960366, 1503960366, 1503960366, 150396036…\n",
      "$ ActivityDate             \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"4/12/2016\", \"4/13/2016\", \"4/14/2016\", \"4/15/…\n",
      "$ TotalSteps               \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 13162, 10735, 10460, 9762, 12669, 9705, 13019…\n",
      "$ TotalDistance            \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 8.50, 6.97, 6.74, 6.28, 8.16, 6.48, 8.59, 9.8…\n",
      "$ TrackerDistance          \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 8.50, 6.97, 6.74, 6.28, 8.16, 6.48, 8.59, 9.8…\n",
      "$ LoggedActivitiesDistance \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …\n",
      "$ VeryActiveDistance       \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1.88, 1.57, 2.44, 2.14, 2.71, 3.19, 3.25, 3.5…\n",
      "$ ModeratelyActiveDistance \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0.55, 0.69, 0.40, 1.26, 0.41, 0.78, 0.64, 1.3…\n",
      "$ LightActiveDistance      \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 6.06, 4.71, 3.91, 2.83, 5.04, 2.51, 4.71, 5.0…\n",
      "$ SedentaryActiveDistance  \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …\n",
      "$ VeryActiveMinutes        \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 25, 21, 30, 29, 36, 38, 42, 50, 28, 19, 66, 4…\n",
      "$ FairlyActiveMinutes      \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 13, 19, 11, 34, 10, 20, 16, 31, 12, 8, 27, 21…\n",
      "$ LightlyActiveMinutes     \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 328, 217, 181, 209, 221, 164, 233, 264, 205, …\n",
      "$ SedentaryMinutes         \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 728, 776, 1218, 726, 773, 539, 1149, 775, 818…\n",
      "$ Calories                 \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 1985, 1797, 1776, 1745, 1863, 1728, 1921, 203…\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "       Id            ActivityDate         TotalSteps    TotalDistance   \n",
       " Min.   :1.504e+09   Length:940         Min.   :    0   Min.   : 0.000  \n",
       " 1st Qu.:2.320e+09   Class :character   1st Qu.: 3790   1st Qu.: 2.620  \n",
       " Median :4.445e+09   Mode  :character   Median : 7406   Median : 5.245  \n",
       " Mean   :4.855e+09                      Mean   : 7638   Mean   : 5.490  \n",
       " 3rd Qu.:6.962e+09                      3rd Qu.:10727   3rd Qu.: 7.713  \n",
       " Max.   :8.878e+09                      Max.   :36019   Max.   :28.030  \n",
       " TrackerDistance  LoggedActivitiesDistance VeryActiveDistance\n",
       " Min.   : 0.000   Min.   :0.0000           Min.   : 0.000    \n",
       " 1st Qu.: 2.620   1st Qu.:0.0000           1st Qu.: 0.000    \n",
       " Median : 5.245   Median :0.0000           Median : 0.210    \n",
       " Mean   : 5.475   Mean   :0.1082           Mean   : 1.503    \n",
       " 3rd Qu.: 7.710   3rd Qu.:0.0000           3rd Qu.: 2.053    \n",
       " Max.   :28.030   Max.   :4.9421           Max.   :21.920    \n",
       " ModeratelyActiveDistance LightActiveDistance SedentaryActiveDistance\n",
       " Min.   :0.0000           Min.   : 0.000      Min.   :0.000000       \n",
       " 1st Qu.:0.0000           1st Qu.: 1.945      1st Qu.:0.000000       \n",
       " Median :0.2400           Median : 3.365      Median :0.000000       \n",
       " Mean   :0.5675           Mean   : 3.341      Mean   :0.001606       \n",
       " 3rd Qu.:0.8000           3rd Qu.: 4.782      3rd Qu.:0.000000       \n",
       " Max.   :6.4800           Max.   :10.710      Max.   :0.110000       \n",
       " VeryActiveMinutes FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes\n",
       " Min.   :  0.00    Min.   :  0.00      Min.   :  0.0        Min.   :   0.0  \n",
       " 1st Qu.:  0.00    1st Qu.:  0.00      1st Qu.:127.0        1st Qu.: 729.8  \n",
       " Median :  4.00    Median :  6.00      Median :199.0        Median :1057.5  \n",
       " Mean   : 21.16    Mean   : 13.56      Mean   :192.8        Mean   : 991.2  \n",
       " 3rd Qu.: 32.00    3rd Qu.: 19.00      3rd Qu.:264.0        3rd Qu.:1229.5  \n",
       " Max.   :210.00    Max.   :143.00      Max.   :518.0        Max.   :1440.0  \n",
       "    Calories   \n",
       " Min.   :   0  \n",
       " 1st Qu.:1828  \n",
       " Median :2134  \n",
       " Mean   :2304  \n",
       " 3rd Qu.:2793  \n",
       " Max.   :4900  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "print('Daily Activity')\n",
    "colnames(daily_activity)\n",
    "glimpse(daily_activity)\n",
    "view(daily_activity)\n",
    "summary(daily_activity)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "5faf248e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.351557Z",
     "iopub.status.busy": "2023-03-29T18:28:59.349962Z",
     "iopub.status.idle": "2023-03-29T18:28:59.388983Z",
     "shell.execute_reply": "2023-03-29T18:28:59.387243Z"
    },
    "papermill": {
     "duration": 0.048054,
     "end_time": "2023-03-29T18:28:59.391192",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.343138",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Daily Calories\"\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Id'</li><li>'ActivityDay'</li><li>'Calories'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Id'\n",
       "\\item 'ActivityDay'\n",
       "\\item 'Calories'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Id'\n",
       "2. 'ActivityDay'\n",
       "3. 'Calories'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"Id\"          \"ActivityDay\" \"Calories\"   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 940\n",
      "Columns: 3\n",
      "$ Id          \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1503960366, 1503960366, 1503960366, 1503960366, 1503960366…\n",
      "$ ActivityDay \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"4/12/2016\", \"4/13/2016\", \"4/14/2016\", \"4/15/2016\", \"4/16/…\n",
      "$ Calories    \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 1985, 1797, 1776, 1745, 1863, 1728, 1921, 2035, 1786, 1775…\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "       Id            ActivityDay           Calories   \n",
       " Min.   :1.504e+09   Length:940         Min.   :   0  \n",
       " 1st Qu.:2.320e+09   Class :character   1st Qu.:1828  \n",
       " Median :4.445e+09   Mode  :character   Median :2134  \n",
       " Mean   :4.855e+09                      Mean   :2304  \n",
       " 3rd Qu.:6.962e+09                      3rd Qu.:2793  \n",
       " Max.   :8.878e+09                      Max.   :4900  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "print('Daily Calories')\n",
    "colnames(daily_calories)\n",
    "glimpse(daily_calories)\n",
    "view(daily_calories)\n",
    "summary(daily_calories)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "522952a6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.405538Z",
     "iopub.status.busy": "2023-03-29T18:28:59.404050Z",
     "iopub.status.idle": "2023-03-29T18:28:59.451133Z",
     "shell.execute_reply": "2023-03-29T18:28:59.449177Z"
    },
    "papermill": {
     "duration": 0.056893,
     "end_time": "2023-03-29T18:28:59.453671",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.396778",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Daily Intesities\"\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Id'</li><li>'ActivityDay'</li><li>'SedentaryMinutes'</li><li>'LightlyActiveMinutes'</li><li>'FairlyActiveMinutes'</li><li>'VeryActiveMinutes'</li><li>'SedentaryActiveDistance'</li><li>'LightActiveDistance'</li><li>'ModeratelyActiveDistance'</li><li>'VeryActiveDistance'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Id'\n",
       "\\item 'ActivityDay'\n",
       "\\item 'SedentaryMinutes'\n",
       "\\item 'LightlyActiveMinutes'\n",
       "\\item 'FairlyActiveMinutes'\n",
       "\\item 'VeryActiveMinutes'\n",
       "\\item 'SedentaryActiveDistance'\n",
       "\\item 'LightActiveDistance'\n",
       "\\item 'ModeratelyActiveDistance'\n",
       "\\item 'VeryActiveDistance'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Id'\n",
       "2. 'ActivityDay'\n",
       "3. 'SedentaryMinutes'\n",
       "4. 'LightlyActiveMinutes'\n",
       "5. 'FairlyActiveMinutes'\n",
       "6. 'VeryActiveMinutes'\n",
       "7. 'SedentaryActiveDistance'\n",
       "8. 'LightActiveDistance'\n",
       "9. 'ModeratelyActiveDistance'\n",
       "10. 'VeryActiveDistance'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"Id\"                       \"ActivityDay\"             \n",
       " [3] \"SedentaryMinutes\"         \"LightlyActiveMinutes\"    \n",
       " [5] \"FairlyActiveMinutes\"      \"VeryActiveMinutes\"       \n",
       " [7] \"SedentaryActiveDistance\"  \"LightActiveDistance\"     \n",
       " [9] \"ModeratelyActiveDistance\" \"VeryActiveDistance\"      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 940\n",
      "Columns: 10\n",
      "$ Id                       \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1503960366, 1503960366, 1503960366, 150396036…\n",
      "$ ActivityDay              \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"4/12/2016\", \"4/13/2016\", \"4/14/2016\", \"4/15/…\n",
      "$ SedentaryMinutes         \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 728, 776, 1218, 726, 773, 539, 1149, 775, 818…\n",
      "$ LightlyActiveMinutes     \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 328, 217, 181, 209, 221, 164, 233, 264, 205, …\n",
      "$ FairlyActiveMinutes      \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 13, 19, 11, 34, 10, 20, 16, 31, 12, 8, 27, 21…\n",
      "$ VeryActiveMinutes        \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 25, 21, 30, 29, 36, 38, 42, 50, 28, 19, 66, 4…\n",
      "$ SedentaryActiveDistance  \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …\n",
      "$ LightActiveDistance      \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 6.06, 4.71, 3.91, 2.83, 5.04, 2.51, 4.71, 5.0…\n",
      "$ ModeratelyActiveDistance \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0.55, 0.69, 0.40, 1.26, 0.41, 0.78, 0.64, 1.3…\n",
      "$ VeryActiveDistance       \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1.88, 1.57, 2.44, 2.14, 2.71, 3.19, 3.25, 3.5…\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "       Id            ActivityDay        SedentaryMinutes LightlyActiveMinutes\n",
       " Min.   :1.504e+09   Length:940         Min.   :   0.0   Min.   :  0.0       \n",
       " 1st Qu.:2.320e+09   Class :character   1st Qu.: 729.8   1st Qu.:127.0       \n",
       " Median :4.445e+09   Mode  :character   Median :1057.5   Median :199.0       \n",
       " Mean   :4.855e+09                      Mean   : 991.2   Mean   :192.8       \n",
       " 3rd Qu.:6.962e+09                      3rd Qu.:1229.5   3rd Qu.:264.0       \n",
       " Max.   :8.878e+09                      Max.   :1440.0   Max.   :518.0       \n",
       " FairlyActiveMinutes VeryActiveMinutes SedentaryActiveDistance\n",
       " Min.   :  0.00      Min.   :  0.00    Min.   :0.000000       \n",
       " 1st Qu.:  0.00      1st Qu.:  0.00    1st Qu.:0.000000       \n",
       " Median :  6.00      Median :  4.00    Median :0.000000       \n",
       " Mean   : 13.56      Mean   : 21.16    Mean   :0.001606       \n",
       " 3rd Qu.: 19.00      3rd Qu.: 32.00    3rd Qu.:0.000000       \n",
       " Max.   :143.00      Max.   :210.00    Max.   :0.110000       \n",
       " LightActiveDistance ModeratelyActiveDistance VeryActiveDistance\n",
       " Min.   : 0.000      Min.   :0.0000           Min.   : 0.000    \n",
       " 1st Qu.: 1.945      1st Qu.:0.0000           1st Qu.: 0.000    \n",
       " Median : 3.365      Median :0.2400           Median : 0.210    \n",
       " Mean   : 3.341      Mean   :0.5675           Mean   : 1.503    \n",
       " 3rd Qu.: 4.782      3rd Qu.:0.8000           3rd Qu.: 2.053    \n",
       " Max.   :10.710      Max.   :6.4800           Max.   :21.920    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "print('Daily Intesities')\n",
    "colnames(daily_intensities)\n",
    "glimpse(daily_intensities)\n",
    "view(daily_intensities)\n",
    "summary(daily_intensities)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "9a7ad0f5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.468973Z",
     "iopub.status.busy": "2023-03-29T18:28:59.467196Z",
     "iopub.status.idle": "2023-03-29T18:28:59.508207Z",
     "shell.execute_reply": "2023-03-29T18:28:59.506209Z"
    },
    "papermill": {
     "duration": 0.051077,
     "end_time": "2023-03-29T18:28:59.510723",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.459646",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Daily Steps\"\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Id'</li><li>'ActivityDay'</li><li>'StepTotal'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Id'\n",
       "\\item 'ActivityDay'\n",
       "\\item 'StepTotal'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Id'\n",
       "2. 'ActivityDay'\n",
       "3. 'StepTotal'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"Id\"          \"ActivityDay\" \"StepTotal\"  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 940\n",
      "Columns: 3\n",
      "$ Id          \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1503960366, 1503960366, 1503960366, 1503960366, 1503960366…\n",
      "$ ActivityDay \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"4/12/2016\", \"4/13/2016\", \"4/14/2016\", \"4/15/2016\", \"4/16/…\n",
      "$ StepTotal   \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 13162, 10735, 10460, 9762, 12669, 9705, 13019, 15506, 1054…\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "       Id            ActivityDay          StepTotal    \n",
       " Min.   :1.504e+09   Length:940         Min.   :    0  \n",
       " 1st Qu.:2.320e+09   Class :character   1st Qu.: 3790  \n",
       " Median :4.445e+09   Mode  :character   Median : 7406  \n",
       " Mean   :4.855e+09                      Mean   : 7638  \n",
       " 3rd Qu.:6.962e+09                      3rd Qu.:10727  \n",
       " Max.   :8.878e+09                      Max.   :36019  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "print('Daily Steps')\n",
    "colnames(daily_steps)\n",
    "glimpse(daily_steps)\n",
    "view(daily_steps)\n",
    "summary(daily_steps)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "3f284488",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.527093Z",
     "iopub.status.busy": "2023-03-29T18:28:59.525239Z",
     "iopub.status.idle": "2023-03-29T18:28:59.574993Z",
     "shell.execute_reply": "2023-03-29T18:28:59.572801Z"
    },
    "papermill": {
     "duration": 0.06071,
     "end_time": "2023-03-29T18:28:59.578049",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.517339",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Weight Logs\"\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Id'</li><li>'Date'</li><li>'WeightKg'</li><li>'WeightPounds'</li><li>'Fat'</li><li>'BMI'</li><li>'IsManualReport'</li><li>'LogId'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Id'\n",
       "\\item 'Date'\n",
       "\\item 'WeightKg'\n",
       "\\item 'WeightPounds'\n",
       "\\item 'Fat'\n",
       "\\item 'BMI'\n",
       "\\item 'IsManualReport'\n",
       "\\item 'LogId'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Id'\n",
       "2. 'Date'\n",
       "3. 'WeightKg'\n",
       "4. 'WeightPounds'\n",
       "5. 'Fat'\n",
       "6. 'BMI'\n",
       "7. 'IsManualReport'\n",
       "8. 'LogId'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"Id\"             \"Date\"           \"WeightKg\"       \"WeightPounds\"  \n",
       "[5] \"Fat\"            \"BMI\"            \"IsManualReport\" \"LogId\"         "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 67\n",
      "Columns: 8\n",
      "$ Id             \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1503960366, 1503960366, 1927972279, 2873212765, 2873212…\n",
      "$ Date           \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"5/2/2016 11:59:59 PM\", \"5/3/2016 11:59:59 PM\", \"4/13/2…\n",
      "$ WeightKg       \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 52.6, 52.6, 133.5, 56.7, 57.3, 72.4, 72.3, 69.7, 70.3, …\n",
      "$ WeightPounds   \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 115.9631, 115.9631, 294.3171, 125.0021, 126.3249, 159.6…\n",
      "$ Fat            \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 22, NA, NA, NA, NA, 25, NA, NA, NA, NA, NA, NA, NA, NA,…\n",
      "$ BMI            \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 22.65, 22.65, 47.54, 21.45, 21.69, 27.45, 27.38, 27.25,…\n",
      "$ IsManualReport \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"True\", \"True\", \"False\", \"True\", \"True\", \"True\", \"True\"…\n",
      "$ LogId          \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1.462234e+12, 1.462320e+12, 1.460510e+12, 1.461283e+12,…\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "       Id                Date              WeightKg       WeightPounds  \n",
       " Min.   :1.504e+09   Length:67          Min.   : 52.60   Min.   :116.0  \n",
       " 1st Qu.:6.962e+09   Class :character   1st Qu.: 61.40   1st Qu.:135.4  \n",
       " Median :6.962e+09   Mode  :character   Median : 62.50   Median :137.8  \n",
       " Mean   :7.009e+09                      Mean   : 72.04   Mean   :158.8  \n",
       " 3rd Qu.:8.878e+09                      3rd Qu.: 85.05   3rd Qu.:187.5  \n",
       " Max.   :8.878e+09                      Max.   :133.50   Max.   :294.3  \n",
       "                                                                        \n",
       "      Fat             BMI        IsManualReport         LogId          \n",
       " Min.   :22.00   Min.   :21.45   Length:67          Min.   :1.460e+12  \n",
       " 1st Qu.:22.75   1st Qu.:23.96   Class :character   1st Qu.:1.461e+12  \n",
       " Median :23.50   Median :24.39   Mode  :character   Median :1.462e+12  \n",
       " Mean   :23.50   Mean   :25.19                      Mean   :1.462e+12  \n",
       " 3rd Qu.:24.25   3rd Qu.:25.56                      3rd Qu.:1.462e+12  \n",
       " Max.   :25.00   Max.   :47.54                      Max.   :1.463e+12  \n",
       " NA's   :65                                                            "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "print('Weight Logs')\n",
    "colnames(weight_log)\n",
    "glimpse(weight_log)\n",
    "view(weight_log)\n",
    "summary(weight_log)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "86db007e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.594974Z",
     "iopub.status.busy": "2023-03-29T18:28:59.593140Z",
     "iopub.status.idle": "2023-03-29T18:28:59.638089Z",
     "shell.execute_reply": "2023-03-29T18:28:59.636130Z"
    },
    "papermill": {
     "duration": 0.055842,
     "end_time": "2023-03-29T18:28:59.640629",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.584787",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Sleep Logs\"\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Id'</li><li>'SleepDay'</li><li>'TotalSleepRecords'</li><li>'TotalMinutesAsleep'</li><li>'TotalTimeInBed'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Id'\n",
       "\\item 'SleepDay'\n",
       "\\item 'TotalSleepRecords'\n",
       "\\item 'TotalMinutesAsleep'\n",
       "\\item 'TotalTimeInBed'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Id'\n",
       "2. 'SleepDay'\n",
       "3. 'TotalSleepRecords'\n",
       "4. 'TotalMinutesAsleep'\n",
       "5. 'TotalTimeInBed'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"Id\"                 \"SleepDay\"           \"TotalSleepRecords\" \n",
       "[4] \"TotalMinutesAsleep\" \"TotalTimeInBed\"    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 413\n",
      "Columns: 5\n",
      "$ Id                 \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1503960366, 1503960366, 1503960366, 1503960366, 150…\n",
      "$ SleepDay           \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"4/12/2016 12:00:00 AM\", \"4/13/2016 12:00:00 AM\", \"…\n",
      "$ TotalSleepRecords  \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …\n",
      "$ TotalMinutesAsleep \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 327, 384, 412, 340, 700, 304, 360, 325, 361, 430, 2…\n",
      "$ TotalTimeInBed     \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 346, 407, 442, 367, 712, 320, 377, 364, 384, 449, 3…\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "       Id              SleepDay         TotalSleepRecords TotalMinutesAsleep\n",
       " Min.   :1.504e+09   Length:413         Min.   :1.000     Min.   : 58.0     \n",
       " 1st Qu.:3.977e+09   Class :character   1st Qu.:1.000     1st Qu.:361.0     \n",
       " Median :4.703e+09   Mode  :character   Median :1.000     Median :433.0     \n",
       " Mean   :5.001e+09                      Mean   :1.119     Mean   :419.5     \n",
       " 3rd Qu.:6.962e+09                      3rd Qu.:1.000     3rd Qu.:490.0     \n",
       " Max.   :8.792e+09                      Max.   :3.000     Max.   :796.0     \n",
       " TotalTimeInBed \n",
       " Min.   : 61.0  \n",
       " 1st Qu.:403.0  \n",
       " Median :463.0  \n",
       " Mean   :458.6  \n",
       " 3rd Qu.:526.0  \n",
       " Max.   :961.0  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "print('Sleep Logs')\n",
    "colnames(daily_sleep)\n",
    "glimpse(daily_sleep)\n",
    "view(daily_sleep)\n",
    "summary(daily_sleep)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "267b558f",
   "metadata": {
    "papermill": {
     "duration": 0.007005,
     "end_time": "2023-03-29T18:28:59.654791",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.647786",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Going through the details there are few things that you can notice:\n",
    "* We can link all the details via ID (It' like a primary key)\n",
    "* Also we have activity date. Through date we can create time series graph for the activities per user.\n",
    "\n",
    "We also need to verify the data, if it's clean or not.\n",
    "In next few steps we will go through the data and clean it."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "9618796a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.672412Z",
     "iopub.status.busy": "2023-03-29T18:28:59.670545Z",
     "iopub.status.idle": "2023-03-29T18:28:59.707606Z",
     "shell.execute_reply": "2023-03-29T18:28:59.705636Z"
    },
    "papermill": {
     "duration": 0.048507,
     "end_time": "2023-03-29T18:28:59.710187",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.661680",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"We can see that one column in weight log has nulls\"\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "      Fat       \n",
       " Min.   :22.00  \n",
       " 1st Qu.:22.75  \n",
       " Median :23.50  \n",
       " Mean   :23.50  \n",
       " 3rd Qu.:24.25  \n",
       " Max.   :25.00  \n",
       " NA's   :65     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Removing NAs\"\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "      Fat         \n",
       " Min.   : 0.0000  \n",
       " 1st Qu.: 0.0000  \n",
       " Median : 0.0000  \n",
       " Mean   : 0.7015  \n",
       " 3rd Qu.: 0.0000  \n",
       " Max.   :25.0000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "print('We can see that one column in weight log has nulls')\n",
    "summary(weight_log['Fat'])\n",
    "print('Removing NAs')\n",
    "weight_log[is.na(weight_log)] <- 0\n",
    "summary(weight_log['Fat'])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "cc154457",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.728467Z",
     "iopub.status.busy": "2023-03-29T18:28:59.726634Z",
     "iopub.status.idle": "2023-03-29T18:28:59.853214Z",
     "shell.execute_reply": "2023-03-29T18:28:59.851366Z"
    },
    "papermill": {
     "duration": 0.138421,
     "end_time": "2023-03-29T18:28:59.855999",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.717578",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(duplicated(weight_log))\n",
    "sum(duplicated(daily_activity))\n",
    "sum(duplicated(daily_calories))\n",
    "sum(duplicated(daily_intensities))\n",
    "sum(duplicated(daily_steps))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "59f23960",
   "metadata": {
    "papermill": {
     "duration": 0.007953,
     "end_time": "2023-03-29T18:28:59.872182",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.864229",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Now we want to check if the sleep pattern actually tells us anything about weight gain/loss"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "1194e30a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.896432Z",
     "iopub.status.busy": "2023-03-29T18:28:59.894974Z",
     "iopub.status.idle": "2023-03-29T18:28:59.954111Z",
     "shell.execute_reply": "2023-03-29T18:28:59.952344Z"
    },
    "papermill": {
     "duration": 0.077278,
     "end_time": "2023-03-29T18:28:59.957204",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.879926",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "weight_data <- weight_log %>%\n",
    "  select(Id,Date,WeightKg,BMI)\n",
    "\n",
    "sleep_data <- daily_sleep %>%\n",
    "  select(Id, SleepDay, TotalMinutesAsleep)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "4794bfb4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:28:59.976567Z",
     "iopub.status.busy": "2023-03-29T18:28:59.975121Z",
     "iopub.status.idle": "2023-03-29T18:28:59.988791Z",
     "shell.execute_reply": "2023-03-29T18:28:59.987252Z"
    },
    "papermill": {
     "duration": 0.02628,
     "end_time": "2023-03-29T18:28:59.991563",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.965283",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "library(ggplot2)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "a8d06416",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:29:00.010788Z",
     "iopub.status.busy": "2023-03-29T18:29:00.009366Z",
     "iopub.status.idle": "2023-03-29T18:29:00.026434Z",
     "shell.execute_reply": "2023-03-29T18:29:00.024800Z"
    },
    "papermill": {
     "duration": 0.029478,
     "end_time": "2023-03-29T18:29:00.029211",
     "exception": false,
     "start_time": "2023-03-29T18:28:59.999733",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "data_kg_sleep <- merge(weight_data, sleep_data, by=c(\"Id\",\"Id\"))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "0e0c0000",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:29:00.048417Z",
     "iopub.status.busy": "2023-03-29T18:29:00.046974Z",
     "iopub.status.idle": "2023-03-29T18:29:00.074352Z",
     "shell.execute_reply": "2023-03-29T18:29:00.072308Z"
    },
    "papermill": {
     "duration": 0.039875,
     "end_time": "2023-03-29T18:29:00.077072",
     "exception": false,
     "start_time": "2023-03-29T18:29:00.037197",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>Date</th><th scope=col>WeightKg</th><th scope=col>BMI</th><th scope=col>SleepDay</th><th scope=col>TotalMinutesAsleep</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>5/3/2016 11:59:59 PM</td><td>52.6</td><td>22.65</td><td>5/8/2016 12:00:00 AM </td><td>594</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>5/3/2016 11:59:59 PM</td><td>52.6</td><td>22.65</td><td>5/7/2016 12:00:00 AM </td><td>331</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>5/3/2016 11:59:59 PM</td><td>52.6</td><td>22.65</td><td>4/26/2016 12:00:00 AM</td><td>245</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>5/3/2016 11:59:59 PM</td><td>52.6</td><td>22.65</td><td>4/16/2016 12:00:00 AM</td><td>340</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>5/3/2016 11:59:59 PM</td><td>52.6</td><td>22.65</td><td>4/12/2016 12:00:00 AM</td><td>327</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>5/3/2016 11:59:59 PM</td><td>52.6</td><td>22.65</td><td>4/13/2016 12:00:00 AM</td><td>384</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 6\n",
       "\\begin{tabular}{r|llllll}\n",
       "  & Id & Date & WeightKg & BMI & SleepDay & TotalMinutesAsleep\\\\\n",
       "  & <dbl> & <chr> & <dbl> & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 5/3/2016 11:59:59 PM & 52.6 & 22.65 & 5/8/2016 12:00:00 AM  & 594\\\\\n",
       "\t2 & 1503960366 & 5/3/2016 11:59:59 PM & 52.6 & 22.65 & 5/7/2016 12:00:00 AM  & 331\\\\\n",
       "\t3 & 1503960366 & 5/3/2016 11:59:59 PM & 52.6 & 22.65 & 4/26/2016 12:00:00 AM & 245\\\\\n",
       "\t4 & 1503960366 & 5/3/2016 11:59:59 PM & 52.6 & 22.65 & 4/16/2016 12:00:00 AM & 340\\\\\n",
       "\t5 & 1503960366 & 5/3/2016 11:59:59 PM & 52.6 & 22.65 & 4/12/2016 12:00:00 AM & 327\\\\\n",
       "\t6 & 1503960366 & 5/3/2016 11:59:59 PM & 52.6 & 22.65 & 4/13/2016 12:00:00 AM & 384\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 6\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | Date &lt;chr&gt; | WeightKg &lt;dbl&gt; | BMI &lt;dbl&gt; | SleepDay &lt;chr&gt; | TotalMinutesAsleep &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 5/3/2016 11:59:59 PM | 52.6 | 22.65 | 5/8/2016 12:00:00 AM  | 594 |\n",
       "| 2 | 1503960366 | 5/3/2016 11:59:59 PM | 52.6 | 22.65 | 5/7/2016 12:00:00 AM  | 331 |\n",
       "| 3 | 1503960366 | 5/3/2016 11:59:59 PM | 52.6 | 22.65 | 4/26/2016 12:00:00 AM | 245 |\n",
       "| 4 | 1503960366 | 5/3/2016 11:59:59 PM | 52.6 | 22.65 | 4/16/2016 12:00:00 AM | 340 |\n",
       "| 5 | 1503960366 | 5/3/2016 11:59:59 PM | 52.6 | 22.65 | 4/12/2016 12:00:00 AM | 327 |\n",
       "| 6 | 1503960366 | 5/3/2016 11:59:59 PM | 52.6 | 22.65 | 4/13/2016 12:00:00 AM | 384 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         Date                 WeightKg BMI   SleepDay             \n",
       "1 1503960366 5/3/2016 11:59:59 PM 52.6     22.65 5/8/2016 12:00:00 AM \n",
       "2 1503960366 5/3/2016 11:59:59 PM 52.6     22.65 5/7/2016 12:00:00 AM \n",
       "3 1503960366 5/3/2016 11:59:59 PM 52.6     22.65 4/26/2016 12:00:00 AM\n",
       "4 1503960366 5/3/2016 11:59:59 PM 52.6     22.65 4/16/2016 12:00:00 AM\n",
       "5 1503960366 5/3/2016 11:59:59 PM 52.6     22.65 4/12/2016 12:00:00 AM\n",
       "6 1503960366 5/3/2016 11:59:59 PM 52.6     22.65 4/13/2016 12:00:00 AM\n",
       "  TotalMinutesAsleep\n",
       "1 594               \n",
       "2 331               \n",
       "3 245               \n",
       "4 340               \n",
       "5 327               \n",
       "6 384               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(data_kg_sleep)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "d6feddb5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:29:00.096714Z",
     "iopub.status.busy": "2023-03-29T18:29:00.095232Z",
     "iopub.status.idle": "2023-03-29T18:29:02.424901Z",
     "shell.execute_reply": "2023-03-29T18:29:02.422342Z"
    },
    "papermill": {
     "duration": 2.343355,
     "end_time": "2023-03-29T18:29:02.428703",
     "exception": false,
     "start_time": "2023-03-29T18:29:00.085348",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = \"cs\")'\n",
      "\n"
     ]
    },
    {
     "data": {
      "image/png": "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\nlsNmGx2S73Zk/PRn6vi86ouGVnamcStijFZ29e603w8ncv4yQM9E64zRJ3undDhMC5P6qlQq\nhUIRjrYxXztfrGW1GCHMjNja9MVBkEs5QjhlGKYybpdCoUhMTIyFFlaAKEKwA9ES5rqzWCxG\nozGSK8w21S/d/Gjawd0n4r7fkd5yaKHDzRTsTd10KGlC/+oJedWhWnA25Gwuyerdqb8eTPa7\nhFei1nnFyFP5PeuDmy4kdtZM67ZkMll6enpVVVVw81HHAoqi9Hq9TqfrDp3qANqGYAdiRlGU\nVqtVq9UNDQ2RX4XsTA1kWHZ9fk/j9qK41XtSKxuaXySyu5g1e1IL/kwZ2rPh4mGm7MQY+uNq\ndUp+OZC8/kCS357ySpnnkqHlE/pXS1pfkqEliUQiLKER+bGl0BqJRJKWlhb4UNmYIpVKk5KS\nxD2nCUDg8MEK4kfTdFxcnFqtrq+vj1ZPFIriR/WuG5FTt7s4bvWetLL65vGO46ldxYZdxYb0\nuOQJ/atG5dSFY2GGwDVYpev2p/x2KMnvBC5BjJAQFt0S1i0NaaUQGhRFJSUlGY3GrtX9V6vV\nGgwGNPoC+GDwRBRg8IRPmAZPtMFut9fX10f3khPPkz9LDD+2uZSqUuYdk1tzQd/aVEOkk2iN\nWfbzvtStRxL8XnilKDI8u/6KkacCX1GDYRi1Wq3T6TrU+Umr1YZk8IQ4hG/wREtWq7W2tjZa\nvRfa5Rs84XK5DAaDiJeUCBAGT0AzaLGD7kWhUKSlpVksFpPJFK3BpxRFhvY0Dsky7jupX7Mn\ntbha3XIfm5NZtz9l3f6UFL0jv2f9sGxjRnzYr5GV1qrW7kvecTyO9zcPHyGkd0rjVaNKs5MC\nnSlQIpHodDr0outaVCqVVCqtra2N5S/SwsofMZs+IfbtqeYcnhA3bEloakRK9D/r0GIXBWix\n84l8i50Pz/ONjY0mkylaw2Z9SmpUGw4k7SqO99tC5pOkcw7Nqh/Wy5jV5oJLHcXzpKRWtavY\nsOdEXI251YukmQnWS/LLh2Q1BHhYmUwmDIwIujM7WuyaimSLnY/ZbI7iwKPWKBSKXr16KZXK\nWHjzxgK02AXn/rWOKmuI849SSn18SeRWGmwNWuygm6IoSkgeUY93WYnWmROLZ5x36rdDCZsO\nJRsbpX53qzbJCvamFuxNjde4eiVZshKsWYm2HvHW4LricTw5XqXZfcKwu9jgd5Vbnz6plouH\n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\nRINmeP9eDRbrgWOnbA5nn6zUUYN60xRFCDlVVb+zsLjeZMlKTTx/aB85K215HI7n/9h37Ghp\npVwmHdi7R152eklF7Z5DJw4Vl3s4LiMprn9Oem5m6vYDRQeKTtnsTq1aoVLIpIyEoql+PdOG\n5fWkKKqs2rhm855DxeUKGTtheN744f2kEv8fgA6Xe/OeI4eKy4wWm1IuG5CT3uzJ1jZYth8o\nqqhpyEiOGz2wt06jbPs8WO3ObfvOnIe87NREQ9v7t8bLcdv3Fx0pqVDKZenJcQ1ma0VtQ4+U\n+JEDcvRt1uB0ebbsPVJ4vNxoblTI2Lxe6aMG5sTp1K3t39oJN5qt2elJY4bkstIo/+1wuT2/\nbD94tKRcr1EO7dezZ1pidOsBiB0IdgEpPF729KKvistrhJsURU0fO/SxWX9VyNjoFgYQuEMn\nyp9e9NXxU9XCTYqiLj5/yD9nX66QN38ZO12eBR99t2rTbp7nhS1ZqYnjh/X9au0fDqdL2KJS\nyB64cfoVk0e29nC/7ih88YNv682NvofzHY0Q0icr5Zm7r/lx0+6lazZ7vZywMSlO++SdV503\nOLfpcYpOVT2z6OtDJ8p9WzKS48qrjVyToxFCGJr2cpzfSgb3yeqZnvjDLzt9Baz+bU+iXrPg\nwRsG52Y223nr3qPz31tRXW9uulGpkD1w4/QrJ48khCxbs/md5QVOp1u4S62QPXjLpX+dMLy1\n87D+jwMLPvrOaLYKN6USZublE+64ajJFUa39il+Hi8seWPDh0dLKlndplPKHbrn0L+OH+f3F\nP/YXzX9vRWVtQ9ONChl73w0XXXPheS33LzpZ9fSirw6XVPi2NDvhqYn6p++6enj/7A7VH0Lb\n9h555JVPTlbWCTdpipoxdfRDN18ikTDRKgkgdjDPPPNMtGsIlMvl8nq9kX9ck8V265OLahos\nTf+OHD1ZVVnbMGnkgCAOKJVKGYZxOp0hK7HLYhhGLpcTQhwOB3/u3+nuSaFQuN3ucLzOGyy2\nW598t7rOzJOz5/nYyarymvrJowY22/mF91f+b+OuplvMNvufR0o93NnCPF5u0+7D/bLTslIT\nWj5cYXHZvQs+tp9JgS0ZzdZVm3bvKixu+v/d7nT9vGX/5FEDDFqVTCZjGMbcaL3+H2+eqqpv\n+uIwW+0tXyttvH6q60yHm+RCgc3hKtiy77IJw1QKmW9jcVn1XfM/bLTZm+3s9ng37TrUNyut\n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\n"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(data_kg_sleep) +\n",
    "  geom_smooth(mapping=aes(x=TotalMinutesAsleep,y=WeightKg)) +\n",
    "  geom_point(mapping=aes(x=TotalMinutesAsleep,y=BMI,color=BMI))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "c25bbec7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:29:02.451955Z",
     "iopub.status.busy": "2023-03-29T18:29:02.450432Z",
     "iopub.status.idle": "2023-03-29T18:29:02.535170Z",
     "shell.execute_reply": "2023-03-29T18:29:02.532829Z"
    },
    "papermill": {
     "duration": 0.098807,
     "end_time": "2023-03-29T18:29:02.538512",
     "exception": false,
     "start_time": "2023-03-29T18:29:02.439705",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Average BMI and Weight for each Users\"\n",
      "\u001b[90m# A tibble: 6 × 4\u001b[39m\n",
      "          Id   bmi    wt TotalMinutesAsleep\n",
      "       \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m              \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m\n",
      "\u001b[90m1\u001b[39m \u001b[4m1\u001b[24m503\u001b[4m9\u001b[24m\u001b[4m6\u001b[24m\u001b[4m0\u001b[24m366  22.6  52.6               360.\n",
      "\u001b[90m2\u001b[39m \u001b[4m1\u001b[24m927\u001b[4m9\u001b[24m\u001b[4m7\u001b[24m\u001b[4m2\u001b[24m279  47.5 134.                417 \n",
      "\u001b[90m3\u001b[39m \u001b[4m4\u001b[24m319\u001b[4m7\u001b[24m\u001b[4m0\u001b[24m\u001b[4m3\u001b[24m577  27.4  72.4               477.\n",
      "\u001b[90m4\u001b[39m \u001b[4m4\u001b[24m558\u001b[4m6\u001b[24m\u001b[4m0\u001b[24m\u001b[4m9\u001b[24m924  27.2  69.6               128.\n",
      "\u001b[90m5\u001b[39m \u001b[4m5\u001b[24m577\u001b[4m1\u001b[24m\u001b[4m5\u001b[24m\u001b[4m0\u001b[24m313  28    90.7               432 \n",
      "\u001b[90m6\u001b[39m \u001b[4m6\u001b[24m962\u001b[4m1\u001b[24m\u001b[4m8\u001b[24m\u001b[4m1\u001b[24m067  24.0  61.6               448 \n"
     ]
    }
   ],
   "source": [
    "print('Average BMI and Weight for each Users')\n",
    "sleep_pattern <- data_kg_sleep %>% \n",
    "group_by(Id) %>% \n",
    "summarize(bmi = mean(BMI), wt = mean(WeightKg), TotalMinutesAsleep=mean(TotalMinutesAsleep))\n",
    "print(sleep_pattern)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "e6fbd74e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-03-29T18:29:02.561712Z",
     "iopub.status.busy": "2023-03-29T18:29:02.559752Z",
     "iopub.status.idle": "2023-03-29T18:29:03.002575Z",
     "shell.execute_reply": "2023-03-29T18:29:02.999898Z"
    },
    "papermill": {
     "duration": 0.457132,
     "end_time": "2023-03-29T18:29:03.005433",
     "exception": false,
     "start_time": "2023-03-29T18:29:02.548301",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`geom_smooth()` using method = 'loess' and formula 'y ~ x'\n",
      "\n"
     ]
    },
    {
     "data": {
      "image/png": "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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# unique(data_kg_sleep['Id'])\n",
    "ggplot(sleep_pattern) +\n",
    "  geom_smooth(mapping=aes(x=bmi,y=wt))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "0762ce3f",
   "metadata": {
    "papermill": {
     "duration": 0.01001,
     "end_time": "2023-03-29T18:29:03.025604",
     "exception": false,
     "start_time": "2023-03-29T18:29:03.015594",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 18.65791,
   "end_time": "2023-03-29T18:29:03.155188",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-03-29T18:28:44.497278",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
