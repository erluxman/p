export const Priority = {
  LOW: "low",
  MEDIUM: "medium",
  HIGH: "high",
} as const;

export type Priority = (typeof Priority)[keyof typeof Priority];

export const PriorityValues = [Priority.LOW, Priority.MEDIUM, Priority.HIGH];

export type PriorityValue = (typeof PriorityValues)[number];
