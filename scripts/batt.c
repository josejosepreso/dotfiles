#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define CAPACITY_PATH "/sys/class/power_supply/BAT0/status"
#define STATUS_PATH "/sys/class/power_supply/BAT0/capacity"

#define LOW_BATTERY_ALERT "echo \"Low Battery\" | dzen2 -h 17 -fn $PANEL_FONT -bg \"#660000\" -p 2 -w 1366"
// #define LOW_BATTERY_ALERT "herbe \"Low Battery\""

void init(char *s, int size)
{
  for (int i = 0; i < size; ++i)
    if (s[i] == '\n') {
      s[i] = '\0';
      return;
    }
}

int main(void)
{
  FILE *f = fopen(CAPACITY_PATH, "r");

  char status[16];
  char capacity[4];

  while (fgets(status, sizeof status, f) != NULL);

  fclose(f);

  init(status, 16);
  
  f = fopen(STATUS_PATH, "r");
  
  while (fgets(capacity, sizeof capacity, f) != NULL);

  fclose(f);

  init(capacity, 4);

  pid_t pid = fork();

  if (pid == 0) {
    if (!strcmp(status, "Discharging") && atoi(capacity) < 15) system(LOW_BATTERY_ALERT);
    exit(0);
  } else {
    printf("%s %s", status, capacity);
  }

  exit(0);
}
