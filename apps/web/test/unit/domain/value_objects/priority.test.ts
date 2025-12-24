import { describe, expect, it } from "vitest";
import {
  Priority,
  PriorityValues,
} from "../../../../src/core/domain/value_objects/priority";

describe("Priority", () => {
  it("should have correct values", () => {
    expect(Priority.LOW).toBe("low");
    expect(Priority.MEDIUM).toBe("medium");
    expect(Priority.HIGH).toBe("high");
  });

  it("should have all priority values in PriorityValues array", () => {
    expect(PriorityValues).toContain(Priority.LOW);
    expect(PriorityValues).toContain(Priority.MEDIUM);
    expect(PriorityValues).toContain(Priority.HIGH);
    expect(PriorityValues.length).toBe(3);
  });
});
